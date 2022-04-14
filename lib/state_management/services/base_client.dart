import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:softcent_test/state_management/services/app_exceptions.dart';

class BaseClient {
  Future<dynamic> getData(String url) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    return _processResponse(response);
  }

  // OTHER
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      // Bad Request
      case 400:
        throw BadRequestException(
          message: utf8.decode(response.bodyBytes),
          url: response.request!.url.toString(),
        );
      // Unauthorized
      case 401:
        throw UnAuthorizedException(
          message: utf8.decode(response.bodyBytes),
          url: response.request!.url.toString(),
        );
      default:
        throw FetchDataException(
          message: "Error occured with code: ${response.statusCode}",
          url: response.request!.url.toString(),
        );
    }
  }
}
