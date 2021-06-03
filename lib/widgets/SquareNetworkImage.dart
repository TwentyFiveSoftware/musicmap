import 'package:flutter/material.dart';

class SquareNetworkImage extends StatelessWidget {
  final double size;
  final String url;

  SquareNetworkImage(this.url, this.size);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColorLight),
        ),
      ),
    );
  }
}
