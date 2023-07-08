import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thiran_task/domain/model/error_response.dart';

class HttpService {
  static final HttpService _instance = HttpService.internal();

  HttpService.internal();

  factory HttpService() => _instance;
  static bool isSuccess(int statusCode) => statusCode > 199 && statusCode < 300;

  /// Get API call
  Future<http.Response> get(String url,
      {Map<String, String> headers = const {},
      bool isOAuthTokenNeeded = true}) async {
    Map<String, String> headers = configHeaders();
    final http.Response response =
        await http.get(Uri.parse(url), headers: headers);
    if (isSuccess(response.statusCode)) {
      return response;
    } else {
      throw ErrorResponse.fromJson(jsonDecode(response.body));
    }
  }

  /// Post API call
  Future<dynamic> post(String url,
      {Map<String, String> headers = const {},
      Map<String, String> params = const {},
      body,
      encoding,
      bool isOAuthTokenNeeded = true}) async {
    headers = isOAuthTokenNeeded ? configHeaders() : headers;
    final response = await http.post(Uri.parse(url),
        headers: headers, body: body, encoding: encoding);

    return jsonDecode(response.body);
  }

  Map<String, String> configHeaders() {
    var headers = <String, String>{};
    headers["Content-Type"] = 'application/json';
    headers["X-Requested-With"] = 'XMLHttpRequest';

    return headers;
  }
}
