import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/NodeInfo.dart';
import '../widgets/ArtistCard.dart';
import '../widgets/SongCard.dart';
import '../database/updateNode.dart';
import '../providers/MusicMapProvider.dart';
import '../providers/SelectNodesProvider.dart';

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
            ? ArtistCard(widget.nodeInfo, selected)
            : SongCard(widget.nodeInfo, selected),
      ),
    );
  }
}
