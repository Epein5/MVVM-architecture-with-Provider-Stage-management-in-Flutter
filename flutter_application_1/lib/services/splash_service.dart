// import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/utils/routes/routes_name.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';

class SplashServices {
  Future<UserModel> getUserCOndition() => UserViewModel().getUser();

  void checkisUserisLoggedIn(BuildContext context) {
    getUserCOndition().then((value) async {
      if (value.token.toString() == null.toString() || value.token == '') {
        await Future.delayed(const Duration(seconds: 1));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RouteName.loginscreen);
        print(value.token);
      } else {
        await Future.delayed(const Duration(seconds: 3));

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RouteName.homescreen);
        print("To homescreen");
        print(value.token);
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

    // Future<bool> setUserCOndition() => UserViewModel().saveUser();

}
