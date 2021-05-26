import 'package:flutter/material.dart';
import './models/NodeInfo.dart';
import './models/EdgeInfo.dart';
import './widgets/MusicMap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicMap',
      theme: ThemeData(
        primaryColor: Color(0xFF282C34),
        primaryColorDark: Color(0xFF21252B),
        accentColor: Color(0xFFA0CE81),
        brightness: Brightness.dark,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

List<NodeInfo> nodes = [
  NodeInfo(0, 30, 200, 'Alan Walker', NodeType.ARTIST),
  NodeInfo(1, 100, 300, 'Faded', NodeType.SONG),
];

List<EdgeInfo> edges = [
  EdgeInfo(0, 1),
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
