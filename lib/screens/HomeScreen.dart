import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/MusicMap.dart';
import '../database/getDatabase.dart';
import '../providers/MusicMapProvider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MusicMap'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await dropDatabase();
              await getDatabase();
              await Provider.of<MusicMapProvider>(context, listen: false).fetchNodesFromDatabase();
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
      ),
      body: MusicMap(),
    );
  }
}
