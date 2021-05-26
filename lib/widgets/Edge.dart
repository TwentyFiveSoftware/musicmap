import 'package:flutter/material.dart';

class Edge extends StatefulWidget {
  final GlobalKey fromNodeKey;
  final GlobalKey toNodeKey;

  Edge(this.fromNodeKey, this.toNodeKey);

  @override
  _EdgeState createState() => _EdgeState();
}

class _EdgeState extends State<Edge> {
  NodeTransform fromNodeTransform = NodeTransform();
  NodeTransform toNodeTransform = NodeTransform();

  NodeTransform getNodeTransform(GlobalKey nodeKey) {
    try {
      RenderBox box = nodeKey.currentContext.findRenderObject() as RenderBox;
      Offset pos = box.localToGlobal(Offset.zero);
      return NodeTransform(x: pos.dx, y: pos.dy, width: box.size.width, height: box.size.height);
    } catch (_) {
      return NodeTransform();
    }
  }

  void updateTransforms() {
    setState(() {
      fromNodeTransform = getNodeTransform(widget.fromNodeKey);
      toNodeTransform = getNodeTransform(widget.toNodeKey);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => updateTransforms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateTransforms();

    return Positioned(
      top: 0,
      left: 0,
      child: Connection(
        fromNodeTransform.x + fromNodeTransform.width / 2,
        fromNodeTransform.y + fromNodeTransform.height / 2,
        toNodeTransform.x + toNodeTransform.width / 2,
        toNodeTransform.y + toNodeTransform.height / 2,
      ),
    );
  }
}

class NodeTransform {
  final double x, y, width, height;

  NodeTransform({this.x = 0, this.y = 0, this.width = 0, this.height = 0});
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
