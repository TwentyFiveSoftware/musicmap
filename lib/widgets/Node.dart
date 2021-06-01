import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/NodeInfo.dart';
import '../widgets/ArtistCard.dart';
import '../widgets/SongCard.dart';
import '../database/updateNode.dart';
import '../providers/MusicMapProvider.dart';
import '../providers/SelectNodesProvider.dart';
import '../config/config.dart' as config;

class Node extends StatefulWidget {
  final NodeInfo nodeInfo;
  final Function updateNodePosition;

  Node(this.nodeInfo, this.updateNodePosition);

  @override
  _NodeState createState() => _NodeState();
}

class _NodeState extends State<Node> {
  Offset moveDelta = Offset.zero;

  @override
  Widget build(BuildContext context) {
    SelectNodesProvider selectNodesProvider =
        Provider.of<SelectNodesProvider>(context, listen: true);

    bool selected = selectNodesProvider.selectedNodes.contains(widget.nodeInfo);

    return Positioned(
      left: widget.nodeInfo.x + moveDelta.dx,
      top: widget.nodeInfo.y + moveDelta.dy,
      child: GestureDetector(
        onTap: () {
          if (selectNodesProvider.selecting) {
            selectNodesProvider.nodeToggleSelected(widget.nodeInfo);
            return;
          }

          Navigator.of(context).pushNamed(
              widget.nodeInfo.type == NodeType.ARTIST
                  ? '/artist_details'
                  : '/song_details',
              arguments: widget.nodeInfo);
        },
        onLongPressStart: (_) => moveDelta = Offset.zero,
        onLongPressMoveUpdate: (details) {
          double x = details.localOffsetFromOrigin.dx;
          double y = details.localOffsetFromOrigin.dy;

          if (widget.nodeInfo.x + x < 0)
            x = -1.0 * widget.nodeInfo.x;
          else if (widget.nodeInfo.x + x + 150 > config.MUSIC_MAP_WIDTH)
            x = config.MUSIC_MAP_WIDTH - 150 - widget.nodeInfo.x;

          if (widget.nodeInfo.y + y < 0)
            y = -1.0 * widget.nodeInfo.y;
          else if (widget.nodeInfo.y + y + 150 > config.MUSIC_MAP_HEIGHT)
            y = config.MUSIC_MAP_HEIGHT - 150 - widget.nodeInfo.y;

          setState(() {
            moveDelta = Offset(x, y);
          });

          widget.updateNodePosition(widget.nodeInfo, Offset(x, y));
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
            ? ArtistCard(widget.nodeInfo, selected)
            : SongCard(widget.nodeInfo, selected),
      ),
    );
  }
}
