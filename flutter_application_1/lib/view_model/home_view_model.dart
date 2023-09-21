import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/response/api_response.dart';
import 'package:flutter_application_1/model/user_list_model.dart';
import 'package:flutter_application_1/repository/home_repositary.dart';

class HomeViewModel extends ChangeNotifier {
  final _myRepo = HomeRepsoitory();
  ApiResponse<UserListModel> userlist = ApiResponse.loading();

  setUserList(ApiResponse<UserListModel> response) {
    userlist = response;
    notifyListeners();
  }

  Future<void> getUserListfunc() async {
    // print('geeetuser');

    // setUserList(ApiResponse.loading());

    _myRepo.getUserList().then((value) {
      // print(userlist.status.toString()+'1');
      setUserList(ApiResponse.complected(value));
      // Future.delayed(Duration.zero,(){setUserList(ApiResponse.complected(value));});
      // print(userlist.status.toString()+'2');
    }).onError((error, stackTrace) {
      setUserList(ApiResponse.error(error.toString()));
    });
  }
}
