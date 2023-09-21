import 'package:flutter_application_1/data/network/BaseApiServices.dart';
import 'package:flutter_application_1/data/network/NetworkApiServices.dart';
import 'package:flutter_application_1/res/url_endpoints.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> login(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(UrlEndpoints.loginUrl.toString(), data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signup(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(UrlEndpoints.signupUrl.toString(), data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
