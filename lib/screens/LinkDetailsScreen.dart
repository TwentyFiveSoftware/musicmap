import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/EdgeInfo.dart';
import '../widgets/LinkDetails.dart';
import '../providers/MusicMapProvider.dart';

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
            onPressed: () async {},
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {},
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
