import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/EdgeInfo.dart';
import '../models/NodeInfo.dart';
import '../providers/MusicMapProvider.dart';

class NodeDetailsLinkSection extends StatelessWidget {
  final String nodeId;

  NodeDetailsLinkSection(this.nodeId);

  @override
  Widget build(BuildContext context) {
    final MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: false);
    final List<LinkInfo> links = provider.getLinksOfNode(nodeId);
    final nodeMap = provider.nodeMap;

    return Column(
      children: links.map((link) {
        NodeInfo node = nodeMap[link.nodeA == nodeId ? link.nodeB : link.nodeA];

        return ListTile(
          onTap: () => Navigator.of(context).pushNamed(
              node.type == NodeType.ARTIST
                  ? '/artist_details'
                  : '/song_details',
              arguments: node),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: link.notes.isEmpty ? 7 : 0,
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          leading: Image.network(
            node.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(
            node.title,
            style: TextStyle(height: 1),
          ),
          subtitle: link.notes.isEmpty ? null : Text(link.notes),
        );
      }).toList(),
    );
  }
}
