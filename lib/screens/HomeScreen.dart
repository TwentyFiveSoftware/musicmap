import 'package:flutter/material.dart';
import '../widgets/MusicMap.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MusicMap'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
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
