import 'package:flutter/material.dart';
import './NodeInfo.dart';

class CurrentlyMovedNodeInfo {
  final NodeInfo nodeInfo;
  final Offset currentMoveOffset;

  CurrentlyMovedNodeInfo(this.nodeInfo, this.currentMoveOffset);
}
