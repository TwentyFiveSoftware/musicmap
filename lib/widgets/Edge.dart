import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';
import '../models/CurrentlyMovedNodeInfo.dart';

class Edge extends StatelessWidget {
  final CurrentlyMovedNodeInfo currentlyMovedNodeInfo;
  final NodeInfo fromNodeInfo;
  final NodeInfo toNodeInfo;
  final bool isLink;

  Edge(this.currentlyMovedNodeInfo, this.fromNodeInfo, this.toNodeInfo, this.isLink);

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
        fromNodeInfo.x + fromNodeOffset + tempFromNodeOffset.dx,
        fromNodeInfo.y + fromNodeOffset + tempFromNodeOffset.dy,
        toNodeInfo.x + toNodeOffset + tempToNodeOffset.dx,
        toNodeInfo.y + toNodeOffset + tempToNodeOffset.dy,
        isLink,
      ),
    );
  }
}

class Connection extends StatelessWidget {
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;
  final bool isLink;

  Connection(this.fromX, this.fromY, this.toX, this.toY, this.isLink);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PathPainter(this.fromX, this.fromY, this.toX, this.toY, isLink),
    );
  }
}

class PathPainter extends CustomPainter {
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;
  final bool bold;

  PathPainter(this.fromX, this.fromY, this.toX, this.toY, this.bold);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = this.bold ? Color(0xFFA0CE81) : Colors.white38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;

    Path path = Path();

    double deltaY = this.toY - this.fromY;

    path.moveTo(this.fromX, this.fromY);
    path.cubicTo(this.fromX, this.fromY + 0.5 * deltaY, this.toX, this.toY - 0.5 * deltaY, this.toX, this.toY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
