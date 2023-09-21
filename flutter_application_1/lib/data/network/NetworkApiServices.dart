import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/data/app_exceptions.dart';
import 'package:flutter_application_1/data/network/BaseApiServices.dart';
import 'package:http/http.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      // print(5);
      final response =
          await get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
      // print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      String jsonData = json.encode(data);
      Response response = await post(Uri.parse(url),
              body: jsonData, headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    // print('haha');
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        // print(response.body);
        // print(response.statusCode);
        return responseJson;
      case 400:
        throw BadRequestException(
            'Invalid input request ${response.body.toString()}');
      case 415:
        throw BadRequestException(response.statusCode.toString()+response.body.toString());
      default:
        throw FetchDataException(
            'Error Occured while Communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
