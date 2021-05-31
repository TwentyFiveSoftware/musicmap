class EdgeInfo {
  final String nodeA;
  final String nodeB;

  EdgeInfo(this.nodeA, this.nodeB);
}

class LinkInfo extends EdgeInfo {
  final String notes;

  LinkInfo(String nodeA, String nodeB, this.notes)
      : super(nodeA, nodeB);
}
