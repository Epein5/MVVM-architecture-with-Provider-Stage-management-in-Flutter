import 'package:flutter_application_1/data/network/BaseApiServices.dart';
import 'package:flutter_application_1/data/network/NetworkApiServices.dart';
import 'package:flutter_application_1/model/user_list_model.dart';
import 'package:flutter_application_1/res/url_endpoints.dart';

class HomeRepsoitory {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getUserList() async {
    try {
      // print(3);
      dynamic response = await _apiServices
          .getGetApiResponse(UrlEndpoints.userlistUrl.toString());
      // print(response);
      return response = UserListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
