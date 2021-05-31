import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/MusicMap.dart';
import '../database/getDatabase.dart';
import '../providers/MusicMapProvider.dart';
import '../providers/SelectNodesProvider.dart';

class HomeScreen extends StatelessWidget {
  Widget normalAppBar(BuildContext context) => AppBar(
        title: Text('MusicMap'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await dropDatabase();
              await getDatabase();
              await Provider.of<MusicMapProvider>(context, listen: false)
                  .update();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/add'),
          ),
        ],
      );

  Widget selectNodesAppBar(
          BuildContext context, SelectNodesProvider provider) =>
      AppBar(
        title: Text('${provider.selectedNodes.length} selected'),
        backgroundColor: Theme.of(context).primaryColorDark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => provider.stopSelecting(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    SelectNodesProvider provider =
        Provider.of<SelectNodesProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        if (provider.selecting) provider.stopSelecting();
        return false;
      },
      child: Scaffold(
        appBar: provider.selecting
            ? selectNodesAppBar(context, provider)
            : normalAppBar(context),
        body: MusicMap(),
      ),
    );
  }
}
