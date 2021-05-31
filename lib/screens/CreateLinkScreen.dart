import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/SelectNodesProvider.dart';

class CreateLinkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SelectNodesProvider provider =
        Provider.of<SelectNodesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('New link'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  provider.startNode.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(provider.startNode.title),
              ),
              Divider(height: 40),
              Text(
                'TO',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              ...provider.selectedNodes.map((node) => ListTile(
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Notes (optional)',
                  labelStyle: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
