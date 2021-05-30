import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Node.dart';
import './Edge.dart';
import '../models/NodeInfo.dart';
import '../models/CurrentlyMovedNodeInfo.dart';
import '../providers/MusicMapProvider.dart';

class MusicMap extends StatefulWidget {
  @override
  _MusicMapState createState() => _MusicMapState();
}

class _MusicMapState extends State<MusicMap> {
  CurrentlyMovedNodeInfo currentlyMovedNodeInfo;

  void moveNode(NodeInfo nodeInfo, Offset offset) {
    if (nodeInfo == null) {
      setState(() {
        currentlyMovedNodeInfo = null;
      });
      return;
    }

    setState(() {
      currentlyMovedNodeInfo = CurrentlyMovedNodeInfo(nodeInfo, offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: true);

    Map<String, NodeInfo> nodeMap = provider.nodeMap;

    List<Node> nodeWidgets =
        provider.nodes.map((node) => Node(node, moveNode)).toList();

    List<Edge> edgeWidgets = provider.edges
        .map((edge) => Edge(
              currentlyMovedNodeInfo,
              nodeMap[edge.fromNodeId],
              nodeMap[edge.toNodeId],
            ))
        .toList();

    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: 0.1,
            maxScale: 4,
            child: SizedBox(
              width: 2000,
              height: 2000,
              child: Stack(
                // overflow: Overflow.visible,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                  ...edgeWidgets,
                  ...nodeWidgets,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
