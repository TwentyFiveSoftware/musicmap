import 'package:flutter/material.dart';

class Edge extends StatelessWidget {
  final GlobalKey fromNodeKey;
  final GlobalKey toNodeKey;

  Edge(this.fromNodeKey, this.toNodeKey);

  NodeTransform getNodeTransform(GlobalKey nodeKey) {
    RenderBox box = nodeKey.currentContext.findRenderObject() as RenderBox;
    Offset pos = box.localToGlobal(Offset.zero);
    return NodeTransform(pos.dx, pos.dy, box.size.width, box.size.height);
  }

  Future<Widget> calculateConnection() async {
    NodeTransform fromNodeTransform;
    NodeTransform toNodeTransform;

    await Future.microtask(() {
      fromNodeTransform = getNodeTransform(fromNodeKey);
      toNodeTransform = getNodeTransform(toNodeKey);
    });

    return Connection(
      fromNodeTransform.x + fromNodeTransform.width / 2,
      fromNodeTransform.y + fromNodeTransform.height,
      toNodeTransform.x + toNodeTransform.width / 2,
      toNodeTransform.y,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: calculateConnection(),
      builder: (_, AsyncSnapshot<Widget> snapshot) => Positioned(
        top: 0,
        left: 0,
        child: snapshot.hasData ? snapshot.data : Container(),
      ),
    );
  }
}

class NodeTransform {
  final double x, y, width, height;

  NodeTransform(this.x, this.y, this.width, this.height);
}

class Connection extends StatelessWidget {
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;

  Connection(this.fromX, this.fromY, this.toX, this.toY);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PathPainter(this.fromX, this.fromY, this.toX, this.toY),
    );
  }
}

class PathPainter extends CustomPainter {
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;

  PathPainter(this.fromX, this.fromY, this.toX, this.toY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFA0CE81)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path = Path();

    path.moveTo(this.fromX, this.fromY);
    path.lineTo(this.toX, this.toY);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
