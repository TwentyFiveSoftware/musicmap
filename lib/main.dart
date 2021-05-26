import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/NodeInfo.dart';
import './models/EdgeInfo.dart';
import './screens/HomeScreen.dart';
import './screens/AddScreen.dart';

void main() {
  runApp(MyApp());
}

List<NodeInfo> nodes = [
  NodeInfo(0, 30, 200, 'Alan Walker', NodeType.ARTIST),
  NodeInfo(1, 100, 300, 'Faded', NodeType.SONG),
  NodeInfo(2, 150, 100, 'Alone', NodeType.SONG),
];

List<EdgeInfo> edges = [
  EdgeInfo(0, 1),
  EdgeInfo(0, 2),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'MusicMap',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFFFFFFF),
        primaryColorDark: Color(0xFFF4F4F4),
        accentColor: Color(0xFFA0CE81),
        backgroundColor: Color(0xFFFFFFFF),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        cursorColor: Color(0xFFA0CE81),
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
        hintColor: Colors.black38,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF282C34),
        primaryColorDark: Color(0xFF21252B),
        accentColor: Color(0xFFA0CE81),
        backgroundColor: Color(0xFF282C34),
        scaffoldBackgroundColor: Color(0xFF282C34),
        cursorColor: Color(0xFFA0CE81),
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
        hintColor: Colors.white38,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(nodes, edges),
        '/add': (_) => AddScreen(),
      },
    );
  }
}
