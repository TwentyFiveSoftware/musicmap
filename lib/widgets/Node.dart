import 'package:flutter/material.dart';
import 'package:musicmap/models/DatabaseSong.dart';
import '../models/NodeInfo.dart';
import '../database/getDatabase.dart';

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
        onLongPressEnd: (_) async {
          setState(() {
            widget.nodeInfo.x = (widget.nodeInfo.x + moveDelta.dx).round();
            widget.nodeInfo.y = (widget.nodeInfo.y + moveDelta.dy).round();
            moveDelta = Offset.zero;
          });

          final db = await getDatabase();

          if (widget.nodeInfo is SongNodeInfo) {
            DatabaseSong song = (widget.nodeInfo as SongNodeInfo).song;
            song.positionX = widget.nodeInfo.x;
            song.positionY = widget.nodeInfo.y;

            await db.update('songs', song.toMap(),
                where: 'id = ?', whereArgs: [song.id]);
          }
        },
        child: Container(
          key: widget.nodeInfo.key,
          child: Text(widget.nodeInfo.text,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2.color)),
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
