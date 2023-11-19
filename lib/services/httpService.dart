import 'package:http/http.dart';
import 'package:laguna/services/authService.dart';

/// A service class for making HTTP requests.
class HttpService {
  /// Sends a GET request to the specified [endpoint].
  ///
  /// Returns a [Future] of [Response] containing the response data.
  static Future<Response> getRequest({required String endpoint}) async {
    final Map<String, String> headers =
        generateHeaders(); // if headers parameter is null, generate default headers
    Response response = await get(
      Uri.parse(endpoint),
      headers: headers,
    );
    extractAndSaveTokensFromResponse(response);
    return response;
  }

  /// Sends a POST request to the specified [endpoint].
  ///
  /// The request [body] can be of any type.
  ///
  /// Optionally, you can provide custom [headers].
  ///
  /// Returns a [Future] of [Response] containing the response data.
  static Future<Response> postRequest(
      {required String endpoint,
      dynamic body,
      Map<String, String>? headers}) async {
    headers ??=
        generateHeaders(); // if headers parameter is null, generate default headers
    Response response =
        await post(Uri.parse(endpoint), body: body, headers: headers);
    extractAndSaveTokensFromResponse(response);
    return response;
  }

  /// Extracts access and refresh tokens from the [response] and saves them to storage.
  ///
  /// The [response] is expected to contain the access and refresh tokens in its headers.
  static void extractAndSaveTokensFromResponse(Response response) {
    String? accessToken = response.headers["x-access-token"];
    String? refreshToken = response.headers["x-refresh-token"];
    if (accessToken != null && refreshToken != null) {
      AuthService().saveTokensToStorage(
          accessToken: accessToken, refreshToken: refreshToken);
    }
  }

  /// Generates default headers for HTTP requests.
  ///
  /// Returns a map of headers.
  static Map<String, String> generateHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }
}
