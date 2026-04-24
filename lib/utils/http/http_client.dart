import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrl = 'https://your-api-base-url.com';
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
    );

    return _handleResponse(response);
  }

  /// POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  /// PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  /// DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
    );

    return _handleResponse(response);
  }

  /// Handle API response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return decoded;

      case 400:
        throw Exception('Bad request: ${decoded['message'] ?? response.body}');

      case 401:
        throw Exception('Unauthorized');

      case 403:
        throw Exception('Forbidden');

      case 404:
        throw Exception('Not found');

      case 500:
        throw Exception('Server error');

      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
