import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes/routes_name.dart';
import 'package:flutter_application_1/view/home_screen.dart';
import 'package:flutter_application_1/view/login_view.dart';
import 'package:flutter_application_1/view/signin_view.dart';
import 'package:flutter_application_1/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homescreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RouteName.loginscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RouteName.signupscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SigninView());

      case RouteName.splashscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No routes Defiend"),
            ),
          );
        });
    }
  }
}
