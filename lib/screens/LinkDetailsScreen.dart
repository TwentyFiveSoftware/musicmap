import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/EdgeInfo.dart';
import '../widgets/LinkDetails.dart';
import '../providers/MusicMapProvider.dart';
import '../database/links.dart';
import '../models/ConfirmDialogInfo.dart';
import '../widgets/ConfirmDialog.dart';

class LinkDetailsScreen extends StatefulWidget {
  @override
  _LinkDetailsScreenState createState() => _LinkDetailsScreenState();
}

class _LinkDetailsScreenState extends State<LinkDetailsScreen> {
  TextEditingController _controller = TextEditingController();
  bool _initialTextSet = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LinkInfo link = ModalRoute.of(context).settings.arguments as LinkInfo;
    MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: false);

    if (!_initialTextSet) {
      setState(() {
        _controller.text = link.notes;
        _initialTextSet = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Link'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => ConfirmDialog(ConfirmDialogInfo(
                title: 'Are you sure?',
                content: 'Do you really want to delete this link?',
                cancelButton: 'Cancel',
                confirmButton: 'Delete',
                successCallback: () async {
                  await deleteLink(link);
                  await Provider.of<MusicMapProvider>(context, listen: false)
                      .update();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )),
            ),
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              link.notes = _controller.text;
              await updateLinkNotes(link);
              await Provider.of<MusicMapProvider>(context, listen: false)
                  .update();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: LinkDetails(
        provider.nodeMap[link.nodeA],
        [provider.nodeMap[link.nodeB]],
        _controller,
        false,
      ),
    );
  }
}
