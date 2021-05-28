import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';
import '../models/CurrentlyMovedNodeInfo.dart';

class Edge extends StatelessWidget {
  final Offset offset;
  final CurrentlyMovedNodeInfo currentlyMovedNodeInfo;
  final NodeInfo fromNodeInfo;
  final NodeInfo toNodeInfo;

  Edge(this.offset, this.currentlyMovedNodeInfo, this.fromNodeInfo,
      this.toNodeInfo);

  @override
  Widget build(BuildContext context) {
    int fromNodeOffset = fromNodeInfo.type == NodeType.ARTIST ? 70 : 42;
    int toNodeOffset = toNodeInfo.type == NodeType.ARTIST ? 70 : 42;

    Offset tempFromNodeOffset = (currentlyMovedNodeInfo != null &&
            fromNodeInfo.id == currentlyMovedNodeInfo.nodeInfo.id)
        ? currentlyMovedNodeInfo.currentMoveOffset
        : Offset.zero;

    Offset tempToNodeOffset = (currentlyMovedNodeInfo != null &&
            toNodeInfo.id == currentlyMovedNodeInfo.nodeInfo.id)
        ? currentlyMovedNodeInfo.currentMoveOffset
        : Offset.zero;

    return Positioned(
      top: 0,
      left: 0,
      child: Connection(
        offset.dx + fromNodeInfo.x + fromNodeOffset + tempFromNodeOffset.dx,
        offset.dy + fromNodeInfo.y + fromNodeOffset + tempFromNodeOffset.dy,
        offset.dx + toNodeInfo.x + toNodeOffset + tempToNodeOffset.dx,
        offset.dy + toNodeInfo.y + toNodeOffset + tempToNodeOffset.dy,
      ),
    );
  }
}

class Connection extends StatelessWidget {
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;

  Connection(this.fromX, this.fromY, this.toX, this.toY);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PathPainter(this.fromX, this.fromY, this.toX, this.toY),
    );
  }
}

class PathPainter extends CustomPainter {
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;

  PathPainter(this.fromX, this.fromY, this.toX, this.toY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFA0CE81)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path = Path();

    path.moveTo(this.fromX, this.fromY);
    path.lineTo(this.toX, this.toY);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
