import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';

class Node extends StatelessWidget {
  final Offset offset;
  final NodeInfo nodeInfo;

  Node(this.offset, this.nodeInfo);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx + nodeInfo.x,
      top: offset.dy + nodeInfo.y,
      child: Container(
        key: nodeInfo.key,
        child: Text(nodeInfo.text),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(nodeInfo.type == NodeType.ARTIST ? 50 : 0),
        ),
      ),
    );
  }
}
