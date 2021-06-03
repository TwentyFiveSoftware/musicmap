import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/NodeInfo.dart';
import '../widgets/SquareNetworkImage.dart';
import '../providers/MusicMapProvider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchQueryController = TextEditingController();
  List<NodeInfo> nodes = [];

  @override
  void initState() {
    super.initState();
    searchQueryController.addListener(searchChangeListener);
  }

  @override
  void dispose() {
    searchQueryController.removeListener(searchChangeListener);
    searchQueryController.dispose();
    super.dispose();
  }

  void searchChangeListener() async {
    List<NodeInfo> allNodes =
        Provider.of<MusicMapProvider>(context, listen: false).nodes;

    allNodes
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

    String searchQuery = searchQueryController.text.toLowerCase();

    setState(() {
      if (searchQueryController.text.isEmpty)
        nodes = allNodes;
      else
        nodes = allNodes
            .where((n) =>
                n.title.toLowerCase().contains(searchQuery) ||
                n.subtitle.toLowerCase().contains(searchQuery))
            .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchQueryController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search for songs, artists or albums',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
          ),
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2.color, fontSize: 16),
          cursorColor: Theme.of(context).accentColor,
        ),
        actions: searchQueryController.text.isEmpty
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => searchQueryController.clear(),
                ),
              ],
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: nodes.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            nodes[index].type == NodeType.ARTIST
                ? '/artist_details'
                : '/song_details',
            arguments: nodes[index],
          ),
          child: ListTile(
            leading: SquareNetworkImage(nodes[index].imageUrl, 50),
            title: Text(nodes[index].title),
            subtitle: nodes[index].type == NodeType.ARTIST
                ? null
                : Text(nodes[index].subtitle),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
