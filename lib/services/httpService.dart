import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:laguna/services/authService.dart';

/// A service class for making HTTP requests.
class HttpService {
  /// Sends a GET request to the specified [endpoint].
  ///
  /// Returns a [Future] of [ResponseWrapper] containing the response data.
  static Future<ResponseWrapper> getRequest({required String endpoint}) async {
    final Map<String, String> headers = generateHeaders(); // if headers parameter is null, generate default headers
    Response response = await get(
      Uri.parse(endpoint),
      headers: headers,
    );
    extractAndSaveTokensFromResponse(response);
    if (response.statusCode >= 200 && response.statusCode <= 208) {
      return ResponseWrapper(
          success: true, statusCode: response.statusCode, responseBody: response.body, bodyBytes: response.bodyBytes);
    } else {
      return ResponseWrapper(
          success: false,
          statusCode: response.statusCode,
          errorMessage: response.reasonPhrase,
          responseBody: response.body);
    }
  }

  /// Sends a POST request to the specified [endpoint].
  ///
  /// The request [body] can be of any type.
  ///
  /// Optionally, you can provide custom [headers].
  ///
  /// Returns a [Future] of [ResponseWrapper] containing the response data.
  static Future<ResponseWrapper> postRequest(
      {required String endpoint, dynamic body, Map<String, String>? headers}) async {
    headers ??= generateHeaders(); // if headers parameter is null, generate default headers

    Response response = await post(Uri.parse(endpoint), body: body, headers: headers);
    extractAndSaveTokensFromResponse(response);
    if (response.statusCode >= 200 && response.statusCode <= 208) {
      return ResponseWrapper(
          success: true, statusCode: response.statusCode, bodyBytes: response.bodyBytes, responseBody: response.body);
    } else {
      return ResponseWrapper(
          success: false,
          statusCode: response.statusCode,
          errorMessage: response.reasonPhrase,
          responseBody: response.body);
    }
  }

  /// Extracts access and refresh tokens from the [response] and saves them to storage.
  ///
  /// The [response] is expected to contain the access and refresh tokens in its headers.
  static void extractAndSaveTokensFromResponse(Response response) {
    String? accessToken = response.headers["x-access-token"];
    String? refreshToken = response.headers["x-refresh-token"];
    if (accessToken != null && refreshToken != null) {
      AuthService().saveTokensToStorage(accessToken: accessToken, refreshToken: refreshToken);
    }
  }

  /// Generates default headers for HTTP requests.
  ///
  /// Returns a map of headers.
  static Map<String, String> generateHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }
}

/// A wrapper class for HTTP response data.
class ResponseWrapper {
  /// Indicates if the request was successful.
  final bool success;

  /// The response status code.
  final int statusCode;

  /// The response body as a string.
  final String? responseBody;

  /// The error message, if the request was not successful.
  final String? errorMessage;

  /// The response body as a byte array.
  final Uint8List? bodyBytes;

  /// Creates a new instance of [ResponseWrapper].
  ResponseWrapper(
      {required this.success, required this.statusCode, this.responseBody, this.errorMessage, this.bodyBytes});
}
