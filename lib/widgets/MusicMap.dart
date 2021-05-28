import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Node.dart';
import './Edge.dart';
import '../models/NodeInfo.dart';
import '../models/EdgeInfo.dart';
import '../providers/MusicMapProvider.dart';

class MusicMap extends StatefulWidget {
  @override
  _MusicMapState createState() => _MusicMapState();
}

class _MusicMapState extends State<MusicMap> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    List<NodeInfo> nodes =
        Provider.of<MusicMapProvider>(context, listen: true).nodes;
    List<EdgeInfo> edges =
        Provider.of<MusicMapProvider>(context, listen: true).edges;

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
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      ...edges
          .map((edge) => Edge(
              nodes.firstWhere((n) => n.id == edge.fromNodeId).key,
              nodes.firstWhere((n) => n.id == edge.toNodeId).key))
          .toList(),
      ...nodes
          .map((node) => Node(offset, node, () => setState(() {})))
          .toList(),
    ]);
  }
}
