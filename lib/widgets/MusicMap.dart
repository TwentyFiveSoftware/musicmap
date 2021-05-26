import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';
import '../models/EdgeInfo.dart';
import './Node.dart';
import './Edge.dart';

class MusicMap extends StatefulWidget {
  final List<NodeInfo> nodes;
  final List<EdgeInfo> edges;

  MusicMap(this.nodes, this.edges);

  @override
  _MusicMapState createState() => _MusicMapState();
}

class _MusicMapState extends State<MusicMap> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onPanUpdate: (details) => setState(() {
          offset = Offset(
            offset.dx + details.delta.dx,
            offset.dy + details.delta.dy,
          );
        }),
        child: SizedBox.expand(
          child: Container(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      ...widget.edges
          .map((edge) => Edge(
              widget.nodes.firstWhere((n) => n.id == edge.fromNodeId).key,
              widget.nodes.firstWhere((n) => n.id == edge.toNodeId).key))
          .toList(),
      ...widget.nodes.map((node) => Node(offset, node)).toList(),
    ]);
  }
}
