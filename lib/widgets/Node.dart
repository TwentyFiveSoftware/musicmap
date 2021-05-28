import 'package:flutter/material.dart';
import 'package:musicmap/widgets/SongCard.dart';
import '../models/NodeInfo.dart';
import '../models/DatabaseSong.dart';
import '../database/getDatabase.dart';
import '../widgets/ArtistCard.dart';

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
        child: widget.nodeInfo is ArtistNodeInfo
            ? ArtistCard(widget.nodeInfo)
            : SongCard(widget.nodeInfo),
        // Container(
        //   key: widget.nodeInfo.key,
        //   width: 300,
        //   child: widget.nodeInfo.type == NodeType.ARTIST
        //       ? Card(
        //           child: ListTile(
        //             contentPadding: const EdgeInsets.symmetric(
        //               vertical: 12.0,
        //               horizontal: 10.0,
        //             ),
        //             leading: Image.network(
        //               widget.nodeInfo.imageUrl,
        //               width: 64,
        //             ),
        //             title: Text(widget.nodeInfo.title),
        //             tileColor: Theme.of(context).primaryColorDark,
        //           ),
        //         )
        //       : ListTile(
        //           contentPadding: const EdgeInsets.symmetric(
        //             vertical: 5.0,
        //             horizontal: 10.0,
        //           ),
        //           leading: Image.network(
        //             widget.nodeInfo.imageUrl,
        //             width: 64,
        //           ),
        //           title: Text(widget.nodeInfo.title),
        //           subtitle: Text(widget.nodeInfo.subtitle),
        //           tileColor: Theme.of(context).primaryColorDark,
        //         ),
      ),
    );
  }
}
