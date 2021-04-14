import 'package:banner_view/banner_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_io/http/api.dart';
import 'package:gank_io/ui/webview_page.dart';

class GirlsPage extends StatefulWidget {
  @override
  _GirlsPageState createState() => _GirlsPageState();
}

class _GirlsPageState extends State<GirlsPage> {
  ///滑动控制器
  ScrollController _controller = new ScrollController();

  List bannerList = [];

  ///控制正在加载的显示
  bool _isLoading = true;
  List articles = [];
  int listTotalSize = 0;

  int curPage = 1;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ///获得 SrollController 监听控件可以滚动的最大范围
      var maxScroll = _controller.position.maxScrollExtent;

      ///获得当前位置的像素值
      var pixels = _controller.position.pixels;

      ///当前滑动位置到达底部，同时还有更多数据
      if (maxScroll == pixels && articles.length < listTotalSize) {
        ///加载更多
        _getGirlsList();
      }
    });
    _pullToRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///正在加载
        Offstage(
          offstage: !_isLoading, //是否隐藏
          child: new Center(child: CupertinoActivityIndicator()),
        ),

        ///内容
        Offstage(
          offstage: _isLoading,
          child: RefreshIndicator(
              child: ListView.builder(
                itemCount: articles.length + 1,
                itemBuilder: (context, i) => _buildItem(i),
                controller: _controller,
              ),
              onRefresh: _pullToRefresh),
        ),
      ],
    );
  }

  ///下拉刷新
  Future<void> _pullToRefresh() async {
    curPage = 1;
    Iterable<Future> futures = [_getGirlsList(), _getBanner()];
    await Future.wait(futures);
    _isLoading = false;
    setState(() {});
    return null;
  }

  _getGirlsList([bool update = true]) async {
    var data = await Api.getGirlsList(curPage);
    if (data != null) {
      var map = data['data'];
      print(map.runtimeType.toString());
      listTotalSize = data["total_counts"];
      if (curPage == 1) {
        articles.clear();
      }
      curPage++;
      articles.addAll(map);

      ///更新ui
      if (update) {
        setState(() {});
      }
    }
  }

  _getBanner([bool update = true]) async {
    var data = await Api.getBanner();
    if (data != null) {
      var dateJson = data["data"];
      bannerList.clear();
      bannerList.addAll(dateJson);
      if (update) {
        setState(() {});
      }
    }
  }

  Widget _buildItem(int i) {
    if (i == 0) {
      return new Container(
        height: 200.0,
        child: _bannerView(),
      );
    }
    var itemData = articles[i - 1];
    return _itemView(itemData);
  }

  Widget _bannerView() {
    var list = bannerList.map((item) {
      return InkWell(
        child: Image.network(item['image'], fit: BoxFit.cover), //fit 图片充满容器
        ///点击事件
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewPage(item["title"], item['url']),
            ),
          );
        },
      );
    }).toList();
    return list.isNotEmpty
        ? Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: BannerView(
                list,
                intervalDuration: const Duration(seconds: 4),
              ),
            ),
          )
        : null;
  }

  Widget _itemView(dynamic itemData) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WebViewPage(itemData["title"], itemData['url']),
            ),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            elevation: 4.0,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    itemData["url"],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Color(0xB3FFFFFF),
                    padding: EdgeInsets.zero,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
                      child: Text(
                        itemData['title'],
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                      child: Text(itemData['desc'],
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.blue)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        itemData['publishedAt'],
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
