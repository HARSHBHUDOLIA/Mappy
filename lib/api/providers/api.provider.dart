import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseUrl;
  const ApiProvider({this.baseUrl = ""});

  Future<Map<String, dynamic>?> makeGetRequest(
    String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final url = Uri.https(baseUrl, endpoint, queryParams);
    final response = await http.get(url, headers: headers);
    if (response.statusCode > 200) {
      return null;
    }
    return json.decode(response.body) as Map<String, dynamic>;
  }
}
