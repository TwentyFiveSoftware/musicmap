class EdgeInfo {
  final String nodeA;
  final String nodeB;

  EdgeInfo(this.nodeA, this.nodeB);
}

class LinkInfo extends EdgeInfo {
  String notes;

  LinkInfo(String nodeA, String nodeB, this.notes) : super(nodeA, nodeB);

  Map<String, dynamic> toMap() => {'a': nodeA, 'b': nodeB, 'notes': notes};
}
