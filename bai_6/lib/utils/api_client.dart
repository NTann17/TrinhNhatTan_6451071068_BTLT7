import 'dart:convert';

import 'package:bai_6/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Map<String, dynamic>> getJson({
    required String path,
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.parse('${AppConstants.baseUrl}$path').replace(
      queryParameters: queryParameters,
    );

    final response = await _client
        .get(uri)
        .timeout(AppConstants.requestTimeout);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Request failed (${response.statusCode})');
    }

    final dynamic data = jsonDecode(response.body);
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response format');
    }

    return data;
  }

  void dispose() {
    _client.close();
  }
}
