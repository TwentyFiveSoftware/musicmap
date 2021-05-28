import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';
import '../models/EdgeInfo.dart';
import './Node.dart';
import './Edge.dart';

const bool LONG_PRESS_TO_MOVE_MAP = false;

class MusicMap extends StatefulWidget {
  final List<NodeInfo> nodes;
  final List<EdgeInfo> edges;

  MusicMap(this.nodes, this.edges);

  @override
  _MusicMapState createState() => _MusicMapState();
}

class _MusicMapState extends State<MusicMap> {
  Offset offset = Offset.zero;
  Offset moveOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onLongPressStart: (_) => moveOffset = Offset.zero,
        onLongPressMoveUpdate: (details) {
          if (!LONG_PRESS_TO_MOVE_MAP) return;
          setState(() {
            moveOffset = details.localOffsetFromOrigin;
          });
        },
        onLongPressEnd: (_) {
          if (!LONG_PRESS_TO_MOVE_MAP) return;
          setState(() {
            offset =
                Offset(offset.dx + moveOffset.dx, offset.dy + moveOffset.dy);
            moveOffset = Offset.zero;
          });
        },
        onPanUpdate: (details) => setState(() {
          if (LONG_PRESS_TO_MOVE_MAP) return;

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
      ...widget.edges
          .map((edge) => Edge(
              widget.nodes.firstWhere((n) => n.id == edge.fromNodeId).key,
              widget.nodes.firstWhere((n) => n.id == edge.toNodeId).key))
          .toList(),
      ...widget.nodes
          .map((node) => Node(offset + moveOffset, node, () => setState(() {})))
          .toList(),
    ]);
  }
}
