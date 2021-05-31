import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/SelectNodesProvider.dart';
import '../providers/MusicMapProvider.dart';
import '../database/createLink.dart';

class CreateLinkScreen extends StatefulWidget {
  @override
  _CreateLinkScreenState createState() => _CreateLinkScreenState();
}

class _CreateLinkScreenState extends State<CreateLinkScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            onPressed: () async {
              await createLink(provider.startNode, provider.selectedNodes, _controller.text);
              provider.stopSelecting();
              await Provider.of<MusicMapProvider>(context, listen: false).update();
              Navigator.of(context).pop();
            },
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
                controller: _controller,
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
