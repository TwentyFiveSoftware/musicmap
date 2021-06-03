import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';
import '../database/links.dart';

class SelectNodesProvider with ChangeNotifier {
  bool _selecting = false;
  List<NodeInfo> _selectedNodes = [];
  NodeInfo _startNode;

  void startSelecting(NodeInfo startNode) {
    _startNode = startNode;
    _selecting = true;
    _selectedNodes.clear();
    notifyListeners();
  }

  void stopSelecting() {
    if (!selecting) return;

    _startNode = null;
    _selecting = false;
    _selectedNodes.clear();
    notifyListeners();
  }

  void nodeToggleSelected(NodeInfo node) async {
    if (_startNode == node) return;
    if (await doesLinkExists(_startNode, node)) return;

    if (_selectedNodes.contains(node))
      _selectedNodes.remove(node);
    else
      _selectedNodes.add(node);

    notifyListeners();
  }

  NodeInfo get startNode => _startNode;

  List<NodeInfo> get selectedNodes => _selectedNodes;

  bool get selecting => _selecting;
}
