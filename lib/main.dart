import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gank_io/ui/category.dart';
import 'package:gank_io/ui/girls.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPageDetail(),
    );
  }
}

class MainPageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Gank.io",
              style: const TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black,
              indicatorWeight: 2.5,
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: [
                Tab(text: "妹子"),
                Tab(text: "Android"),
                Tab(text: "Flutter"),
                Tab(text: "iOS"),
              ],
            ),
          ),
          body: MainPageBody(),
          drawer: Drawer(
            child: LeftDrawer(),
          ),
        ));
  }
}

class MainPageBody extends StatefulWidget {
  @override
  _MainPageBodyState createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        GirlsPage(),
        CategoryPage("Android"),
        CategoryPage("Flutter"),
        CategoryPage("iOS"),
      ],
    );
  }
}

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: InkWell(
              onTap: () => {},
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 18.0),
                    child: CircleAvatar(
                      radius: 38.0,
                      backgroundColor: Colors.grey,
                      child: Image.asset(
                        "assets/images/user_header.png",
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  Text(
                    "Welcome to Gank.io",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  )
                ],
              ),
            )),
        InkWell(
          onTap: () => {print("收藏")},
          child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                "关于",
                style: const TextStyle(fontSize: 16.0),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
          child: Divider(
            height: 0.5,
            color: Colors.grey,
          ),
        ),
        InkWell(
          onTap: () => {pop()},
          child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "退出",
                style: const TextStyle(fontSize: 16.0),
              )),
        )
      ],
    );
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
