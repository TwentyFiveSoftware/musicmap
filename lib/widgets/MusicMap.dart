import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Node.dart';
import './Edge.dart';
import '../models/NodeInfo.dart';
import '../models/EdgeInfo.dart';
import '../models/CurrentlyMovedNodeInfo.dart';
import '../providers/MusicMapProvider.dart';
import '../config/config.dart' as config;

class MusicMap extends StatefulWidget {
  @override
  _MusicMapState createState() => _MusicMapState();
}

class _MusicMapState extends State<MusicMap> with TickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController(Matrix4.translationValues(
          -config.MUSIC_MAP_WIDTH / 2, -config.MUSIC_MAP_HEIGHT / 2, 0));
  AnimationController _animationController;

  CurrentlyMovedNodeInfo currentlyMovedNodeInfo;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          Duration(milliseconds: config.TRANSITION_TO_MAP_POSITION_DURATION),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  void transitionToPosition(Offset position, Size deviceSize) {
    Matrix4Tween tween = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.translationValues(
        -position.dx + deviceSize.width * 0.3,
        -position.dy + deviceSize.height * 0.3,
        0,
      ),
    );

    final Animation<double> animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutCubic);

    void onAnimation() {
      _transformationController.value = tween.lerp(animation.value);

      if (!_animationController.isAnimating) {
        _animationController.removeListener(onAnimation);
        _animationController.reset();
      }
    }

    animation.addListener(onAnimation);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: true);

    if (provider.transitionToPositionOnNextMapView != null) {
      transitionToPosition(provider.transitionToPositionOnNextMapView,
          MediaQuery.of(context).size);
      provider.transitionToPositionOnNextMapView = null;
    }

    Map<String, NodeInfo> nodeMap = provider.nodeMap;

    List<Node> nodeWidgets =
        provider.nodes.map((node) => Node(node, moveNode)).toList();

    List<Edge> edgeWidgets = provider.edges
        .map((edge) => Edge(
              currentlyMovedNodeInfo,
              nodeMap[edge.nodeA],
              nodeMap[edge.nodeB],
              edge is LinkInfo,
            ))
        .toList();

    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: InteractiveViewer(
            transformationController: _transformationController,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: config.MUSIC_MAP_MIN_SCALE,
            maxScale: config.MUSIC_MAP_MAX_SCALE,
            child: SizedBox(
              width: config.MUSIC_MAP_WIDTH,
              height: config.MUSIC_MAP_HEIGHT,
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
