import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/NodeInfo.dart';
import '../widgets/ArtistCard.dart';
import '../widgets/SongCard.dart';
import '../database/updateNode.dart';
import '../providers/MusicMapProvider.dart';

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
          });
          widget.updateNodePosition(
              widget.nodeInfo, details.localOffsetFromOrigin);
        },
        onLongPressEnd: (_) async {
          widget.nodeInfo.updatePosition(
            (widget.nodeInfo.x + moveDelta.dx).round(),
            (widget.nodeInfo.y + moveDelta.dy).round(),
          );

          await updateNode(widget.nodeInfo);
          await Provider.of<MusicMapProvider>(context, listen: false).update();

          widget.updateNodePosition(null, null);
          moveDelta = Offset.zero;
        },
        child: widget.nodeInfo is ArtistNodeInfo
            ? ArtistCard(widget.nodeInfo)
            : SongCard(widget.nodeInfo),
      ),
    );
  }
}
