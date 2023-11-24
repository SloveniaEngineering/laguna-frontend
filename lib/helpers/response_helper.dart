import 'package:http/http.dart';

class ResponseHelper {
  static bool isSuccess(Response response) {
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
