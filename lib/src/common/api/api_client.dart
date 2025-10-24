import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_browser_app/env/env.dart';

class ApiClient {
  static const String _baseUrl = 'https://api.themoviedb.org/3/';

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.parse('$_baseUrl$path').replace(
      queryParameters: {...?queryParameters, 'api_key': Env.tmdbApiKey},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
