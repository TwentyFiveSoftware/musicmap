import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/SelectNodesProvider.dart';
import '../providers/MusicMapProvider.dart';
import '../database/createLink.dart';
import '../widgets/LinkDetails.dart';

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
              await createLink(
                  provider.startNode, provider.selectedNodes, _controller.text);
              provider.stopSelecting();
              await Provider.of<MusicMapProvider>(context, listen: false)
                  .update();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: LinkDetails(
        provider.startNode,
        provider.selectedNodes,
        _controller,
        true,
      ),
    );
  }
}
