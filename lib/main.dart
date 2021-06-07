import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'routes/Routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉debug图标
      // home:Tabs(),
      initialRoute: '/', //初始化的时候加载的路由
      onGenerateRoute: onGenerateRoute,
    );
  }
}
