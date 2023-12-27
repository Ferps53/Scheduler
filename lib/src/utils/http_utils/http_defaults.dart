import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_list/src/utils/http_utils/http_methods_enum.dart';

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
    required HttpMethods httpMethod,
    Object? body,
  }) {
    final Uri url = Uri.parse("$rootPath/$endpoints");

    print(url.toString());

    switch (httpMethod) {
      case HttpMethods.get:
        return http.get(url, headers: headers);
      case HttpMethods.post:
        return http.post(url, headers: headers, body: jsonEncode(body));
      case HttpMethods.put:
        return http.put(url, headers: headers, body: jsonEncode(body));
      case HttpMethods.patch:
        return http.patch(url, headers: headers, body: jsonEncode(body));
      case HttpMethods.delete:
        return http.delete(url, headers: headers);
      default:
        throw Exception("Método Http incorreto!");
    }
  }
}
