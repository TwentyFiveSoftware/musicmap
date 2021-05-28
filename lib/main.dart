import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import './models/NodeInfo.dart';
import './models/EdgeInfo.dart';
import './models/DatabaseSong.dart';
import './screens/HomeScreen.dart';
import './screens/AddScreen.dart';
import './database/getDatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  final db = await getDatabase();
  List<Map<String, dynamic>> songs = await db.query('songs');
  List<NodeInfo> nodes = songs
      .map((song) => SongNodeInfo(DatabaseSong.fromDatabase(song)))
      .toList();

  runApp(MyApp(nodes, []));
}

class MyApp extends StatelessWidget {
  final List<NodeInfo> nodes;
  final List<EdgeInfo> edges;

  MyApp(this.nodes, this.edges);

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
