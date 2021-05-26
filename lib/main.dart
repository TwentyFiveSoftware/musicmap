import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Transform {
  final double x, y, width, height;

  Transform(this.x, this.y, this.width, this.height);
}

class Home extends StatelessWidget {
  final double offsetX = 0;
  final double offsetY = 0;

  final List<GlobalKey> keys = [GlobalKey(), GlobalKey()];

  Future<List<Widget>> getConnections() async {
    List<Transform> transforms = [];

    await Future.microtask(() {
      transforms = keys.map((key) {
        RenderBox box = key.currentContext.findRenderObject() as RenderBox;
        Offset pos = box.localToGlobal(Offset.zero);
        return Transform(pos.dx, pos.dy, box.size.width, box.size.height);
      }).toList();
    });

    return [
      Connection(
        transforms[0].x + transforms[0].width / 2,
        transforms[0].y + transforms[0].height,
        transforms[1].x + transforms[1].width / 2,
        transforms[1].y,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MusicMap'),
      // ),
      body: Stack(
        children: [
          Positioned(
            key: keys[0],
            left: offsetX + 30,
            top: offsetY + 200,
            child: Container(
              child: Text('Alan Walker'),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            key: keys[1],
            left: offsetX + 100,
            top: offsetY + 300,
            child: Container(
              child: Text('Faded'),
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: FutureBuilder(
              future: getConnections(),
              builder: (context, AsyncSnapshot<List<Widget>> snapshot) =>
                  Column(
                children: snapshot.hasData ? snapshot.data : [],
              ),
            ),
          )
        ],
      ),
    );
  }
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
      ..color = Colors.blue
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
