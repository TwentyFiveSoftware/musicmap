import 'dart:convert';
import 'package:http/http.dart' as http;
import './getSpotifyToken.dart';

Future<Map<String, dynamic>> spotifyApiRequest(String url) async {
  String accessToken = await getSpotifyToken();

  http.Response response = await http.get(
      Uri.parse('https://api.spotify.com/v1/$url'),
      headers: {'authorization': 'Bearer $accessToken'});

  return jsonDecode(response.body);
}
