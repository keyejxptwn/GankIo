import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                  "以上接口来自干货集中营：https://gank.io/\n本项目只做学习使用\n项目地址：https://github.com/keyejxptwn/GankIo\n欢迎Star或指正！",
                  style: TextStyle(color: Colors.blue, fontSize: 20.0)),
            )
          ],
        ),
      ),
    );
  }
}
