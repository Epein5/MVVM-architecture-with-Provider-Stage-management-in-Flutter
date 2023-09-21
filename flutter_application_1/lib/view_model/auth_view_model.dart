import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/repository/auth_repository.dart';
import 'package:flutter_application_1/utils/routes/routes_name.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setloading(value) {
    _loading = value;
    notifyListeners();
  }

  final _myRepo = AuthRepository();

  Future<void> login(dynamic data, BuildContext context) async {
    setloading(true);
    _myRepo.login(data).then((value) {
      Utils.snackBar("Successfully logged in", context);
      setloading(false);
      Navigator.pushNamed(context, RouteName.homescreen);

      if (kDebugMode) {
        print(value.toString());
      }
      UserViewModel userViewModel = UserViewModel();
      userViewModel.saveUser(UserModel(token: value['token'].toString()));

      // if (value['code'] == 0) {
      //   Navigator.pushNamed(context, RouteName.homescreen);
      //   Utils.snackBar("Successfully logged in", context);
      //   setloading(false);
      // } else {
      //   Utils.flushBarErrorMessage(value['message'].toString(), context);
      //   setloading(false);
      // }
    }).onError((error, stackTrace) {
      setloading(false);

      if (kDebugMode) {
        print(error.toString());
        Utils.flushBarErrorMessage(error.toString(), context);
      }
    });
  }

  Future<void> signup(dynamic data, BuildContext context) async {
    setloading(true);
    _myRepo.signup(data).then((value) {
      Utils.snackBar("Successfully Signed  in", context);
      setloading(false);

      // if (value['code'] == 0) {
      //   Utils.snackBar("Account Created Successfully", context);
      //   setloading(false);
      // } else {
      //   Utils.flushBarErrorMessage(value['message'], context);
      //   setloading(false);
      // }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setloading(false);
    });
  }
}
