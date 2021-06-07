import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "入职测试专用",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          centerTitle: true,
          primary: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //修改颜色
          ),
        ),
        body: ListView(
          children: [
            RaisedButton(
              child: Text("入职测试-姓名"),
              onPressed: () {
                Navigator.pushNamed(context, '/test');
              },
            )
          ],
        ));
  }
}
