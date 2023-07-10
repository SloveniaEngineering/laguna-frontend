import 'dart:typed_data';

import 'package:http/http.dart';

class HttpService {
  static Future<ResponseWrapper> getRequest({required String endpoint, String? token}) async {
    final Map<String, String> headers = generateHeaders(); // if headers parameter is null, generate default headers
    Response response = await get(
      Uri.parse(endpoint),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return ResponseWrapper(success: true, responseBody: response.body, bodyBytes: response.bodyBytes);
    } else {
      return ResponseWrapper(success: false, errorMessage: response.reasonPhrase, responseBody: response.body);
    }
  }

  static Future<ResponseWrapper> postRequest(
      {required String endpoint, dynamic body, Map<String, String>? headers}) async {
    headers ??= generateHeaders(); // if headers parameter is null, generate default headers

    Response response = await post(Uri.parse(endpoint), body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ResponseWrapper(success: true, bodyBytes: response.bodyBytes, responseBody: response.body);
    } else {
      return ResponseWrapper(success: false, errorMessage: response.reasonPhrase, responseBody: response.body);
    }
  }

  static Map<String, String> generateHeaders() {
    return {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'};
  }
}

class ResponseWrapper {
  final bool success;
  final String? responseBody;
  final String? errorMessage;
  final Uint8List? bodyBytes;
  ResponseWrapper({required this.success, this.responseBody, this.errorMessage, this.bodyBytes});
}
