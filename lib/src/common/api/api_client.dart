import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../env/env.dart';

class ApiClient {
  ApiClient({required http.Client client}) : _client = client;

  final http.Client _client;
  static const String _baseUrl = 'https://api.themoviedb.org/3/';

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.parse('$_baseUrl$path').replace(
      queryParameters: {...?queryParameters, 'api_key': Env.tmdbApiKey},
    );

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}

final apiClientProvider = Provider((ref) => ApiClient(client: http.Client()));
