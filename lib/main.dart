import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/NodeInfo.dart';
import './models/EdgeInfo.dart';
import './widgets/MusicMap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'MusicMap',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFFFFFFF),
        primaryColorDark: Color(0xFFF4F4F4),
        accentColor: Color(0xFFA0CE81),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF282C34),
        primaryColorDark: Color(0xFF21252B),
        accentColor: Color(0xFFA0CE81),
      ),
      themeMode: ThemeMode.system,
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

List<NodeInfo> nodes = [
  NodeInfo(0, 30, 200, 'Alan Walker', NodeType.ARTIST),
  NodeInfo(1, 100, 300, 'Faded', NodeType.SONG),
  NodeInfo(2, 150, 100, 'Alone', NodeType.SONG),
];

List<EdgeInfo> edges = [
  EdgeInfo(0, 1),
  EdgeInfo(0, 2),
];

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MusicMap'),
      // ),
      body: MusicMap(nodes, edges),
    );
  }
}
