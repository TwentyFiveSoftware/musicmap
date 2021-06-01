import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';

class LinkDetails extends StatelessWidget {
  final NodeInfo fromNode;
  final List<NodeInfo> toNodes;
  final TextEditingController notesController;
  final bool isCreateScreen;

  LinkDetails(
      this.fromNode, this.toNodes, this.notesController, this.isCreateScreen);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCreateScreen)
              Text(
                'FROM',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: Image.network(
                fromNode.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(fromNode.title),
            ),
            if (isCreateScreen) Divider(height: 40),
            if (isCreateScreen)
              Text(
                'TO',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            ...toNodes.map((node) => ListTile(
                  contentPadding: const EdgeInsets.all(5),
                  leading: Image.network(
                    node.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(node.title),
                )),
            Divider(height: 40),
            TextField(
              controller: notesController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                border: const OutlineInputBorder(),
                labelText: 'Notes' + (isCreateScreen ? ' (optional)' : ''),
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
