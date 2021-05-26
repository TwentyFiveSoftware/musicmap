import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';

class Node extends StatefulWidget {
  final Offset offset;
  final NodeInfo nodeInfo;
  final Function updateNodePosition;

  Node(this.offset, this.nodeInfo, this.updateNodePosition);

  @override
  _NodeState createState() => _NodeState();
}

class _NodeState extends State<Node> {
  Offset moveDelta = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.offset.dx + widget.nodeInfo.x + moveDelta.dx,
      top: widget.offset.dy + widget.nodeInfo.y + moveDelta.dy,
      child: GestureDetector(
        onLongPressStart: (_) => moveDelta = Offset.zero,
        onLongPressMoveUpdate: (details) {
          setState(() {
            moveDelta = details.localOffsetFromOrigin;
            widget.updateNodePosition();
          });
        },
        onLongPressEnd: (_) {
          setState(() {
            widget.nodeInfo.x += moveDelta.dx;
            widget.nodeInfo.y += moveDelta.dy;
            moveDelta = Offset.zero;
          });
        },
        child: Container(
          key: widget.nodeInfo.key,
          child: Text(widget.nodeInfo.text, style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color)),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(
                widget.nodeInfo.type == NodeType.ARTIST ? 50 : 0),
          ),
        ),
      ),
    );
  }
}
