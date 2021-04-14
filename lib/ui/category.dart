import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_io/http/api.dart';
import 'package:gank_io/ui/webview_page.dart';

class CategoryPage extends StatefulWidget {
  String type;

  CategoryPage(this.type);

  @override
  _CategoryPageState createState() => _CategoryPageState(type);
}

class _CategoryPageState extends State<CategoryPage> {
  String type;

  _CategoryPageState(this.type);

  bool _isLoading = true;
  int curPage = 1;
  List articles = [];
  int listTotalSize = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && articles.length < listTotalSize) {
        _getAndroidList();
      }
    });
    _pullToRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
            offstage: !_isLoading,
            child: Center(
              child: CupertinoActivityIndicator(),
            )),
        Offstage(
          offstage: _isLoading,
          child: RefreshIndicator(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, i) => _buildItem(i),
              controller: _controller,
            ),
            onRefresh: _pullToRefresh,
          ),
        )
      ],
    );
  }

  Future<void> _pullToRefresh() async {
    curPage = 1;
    Iterable<Future> futures = [_getAndroidList()];
    await Future.wait(futures);
    _isLoading = false;
    setState(() {});
    return null;
  }

  _getAndroidList([bool update = true]) async {
    var data = await Api.getCategoryList(curPage, type);
    if (data != null) {
      var map = data['data'];
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

  Widget _buildItem(dynamic position) {
    var itemData = articles[position];
    List imageList = itemData['images'];
    print(imageList.runtimeType);
    return articles.isNotEmpty
        ? Container(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: InkWell(
              onTap: () => _onItemClick(itemData),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                elevation: 4.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0)),
                          child: imageList.isNotEmpty
                              ? imageList[0].toString().contains("http")
                                  ? Image.network(
                                      imageList[0],
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/placeholder.png",
                                      fit: BoxFit.cover,
                                    )
                              : Image.asset(
                                  "assets/images/placeholder.png",
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Container(
                      width: 250,
                      height: 120,
                      padding: EdgeInsets.all(5.0),
                      child: Expanded(
                          child: Center(
                        child: Text(
                          itemData["title"],
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          )
        : null;
  }

  void _onItemClick(var item) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            WebViewPage(title: item["title"], url: item['url']),
      ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
