import 'package:flutter/material.dart';
import './models/NodeInfo.dart';
import './models/EdgeInfo.dart';
import './widgets/Node.dart';
import './widgets/Edge.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicMap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final Offset offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MusicMap'),
      // ),
      body: Stack(children: [
        ...nodes.map((node) => Node(offset, node)).toList(),
        ...edges
            .map((edge) => Edge(
                nodes.firstWhere((n) => n.id == edge.fromNodeId).key,
                nodes.firstWhere((n) => n.id == edge.toNodeId).key))
            .toList(),
      ]),
    );
  }
}
