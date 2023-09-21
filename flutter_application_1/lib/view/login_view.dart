import 'package:flutter/material.dart';
import 'package:flutter_application_1/res/components/round_button.dart';
import 'package:flutter_application_1/utils/routes/routes_name.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> ishidden = ValueNotifier<bool>(true);

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ishidden.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          focusNode: emailFocusNode,
          onFieldSubmitted: (value) {
            Utils.changeFocusNode(context, emailFocusNode, passwordFocusNode);
          },
          controller: _emailcontroller,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email), hintText: "Email"),
        ),
        ValueListenableBuilder(
          valueListenable: ishidden,
          builder: (context, value, child) {
            return TextFormField(
              focusNode: passwordFocusNode,
              obscureText: ishidden.value,
              obscuringCharacter: '*',
              controller: _passwordcontroller,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: () {
                        ishidden.value = !ishidden.value;
                      },
                      child: ishidden.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  hintText: "Password"),
            );
          },
        ),
        SizedBox(height: height * 0.05),
        Consumer<AuthViewModel>(
          builder: (context, value, child) {
            return RoundButton(
              text: "SignIn",
              onPress: () {
                print(_emailcontroller.text);
                if (_emailcontroller.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please Enter Email", context);
                }

                // if (!(_passwordcontroller.text.length > 5)) {
                //   Utils.flushBarErrorMessage(
                //       "Please enter proper password", context);
                // }
                else {
                  // Map data = {
                  //   'email': _emailcontroller.text.trim().toString(),
                  //   'password': _passwordcontroller.text.toString()
                  // };

                  Map data = {
                    'email': 'eve.holt@reqres.in',
                    'password': 'cityslicka'
                  };
                  authViewModel.login(data, context);
                }
              },
              loading: value.loading,
            );
          },
        ),
        SizedBox(
          height: height * 0.05,
        ),
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.signupscreen);
            },
            child: const Text("Dont have a account ? Signup here"))
      ],
    )));
  }
}
