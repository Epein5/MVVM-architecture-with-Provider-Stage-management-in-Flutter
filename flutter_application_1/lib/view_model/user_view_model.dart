import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    print('getUser');
    return UserModel(token: token.toString());
  }

  Future<bool> RemoveUser() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print("Destroyed${_pref.getString('token')}");
    }
    return _pref.clear();
  }
}
