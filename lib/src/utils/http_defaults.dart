import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpDefaults {
  static Map<String, String> gerarHeaderPadrao({String? token}) {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    return headers;
  }

  static Future<http.Response> gerarChamadaHttpPadrao({
    required String rootPath,
    required String endpoints,
    required Map<String, String> headers,
    required String httpMethod,
    Object? body,
  }) {
    final Uri url = Uri.parse("$rootPath/$endpoints");

    print(url.toString());

    switch (httpMethod) {
      case "get":
        return http.get(url, headers: headers);
      case "post":
        return http.post(url, headers: headers, body: jsonEncode(body));
      case "put":
        return http.put(url, headers: headers, body: jsonEncode(body));
      case "patch":
        return http.patch(url, headers: headers, body: jsonEncode(body));
      case "delete":
        return http.delete(url, headers: headers);
      default:
        throw Exception("Método Http incorreto!");
    }
  }
}
