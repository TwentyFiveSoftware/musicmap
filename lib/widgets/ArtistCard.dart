import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';
import '../widgets/SquareNetworkImage.dart';

class ArtistCard extends StatelessWidget {
  final ArtistNodeInfo artistNodeInfo;
  final bool selected;

  ArtistCard(this.artistNodeInfo, this.selected);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          border: this.selected ? Border.all(color: Theme.of(context).accentColor) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SquareNetworkImage(artistNodeInfo.imageUrl, 100),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                artistNodeInfo.title,
                style: TextStyle(fontSize: 17),
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
