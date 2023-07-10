import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';

class HttpService {
  static Future<ResponseWrapper> getRequest({required String endpoint, bool utfdecode = true, String? token}) async {
    Response response = await get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json; charset=UTF-16',
        if (token != null) 'Authorization': 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      return ResponseWrapper(
          success: true,
          responseBody: utfdecode ? utf8.decode(response.bodyBytes) : response.body,
          bodyBytes: response.bodyBytes);
    } else {
      return ResponseWrapper(success: false, errorMessage: response.reasonPhrase, responseBody: response.body);
    }
  }

  static Future<ResponseWrapper> postRequest(
      {required String endpoint, dynamic body, bool utfdecode = true, Map<String, String>? headers}) async {
    Response response = await post(Uri.parse(endpoint), body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ResponseWrapper(
          success: true,
          bodyBytes: response.bodyBytes,
          responseBody: utfdecode ? utf8.decode(response.bodyBytes) : response.body);
    } else {
      return ResponseWrapper(
          success: false,
          errorMessage: response.reasonPhrase,
          responseBody: utfdecode ? utf8.decode(response.bodyBytes) : response.body);
    }
  }
}

class ResponseWrapper {
  final bool success;
  final String? responseBody;
  final String? errorMessage;
  final Uint8List? bodyBytes;
  ResponseWrapper({required this.success, this.responseBody, this.errorMessage, this.bodyBytes});
}
