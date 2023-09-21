import 'package:flutter/material.dart';
import 'package:flutter_application_1/res/components/round_button.dart';
import 'package:flutter_application_1/utils/routes/routes_name.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  ValueNotifier<bool> ishidden = ValueNotifier<bool>(true);

  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  FocusNode nameFocusNode = FocusNode();

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
    nameFocusNode.dispose();
    _namecontroller.dispose();
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
          focusNode: nameFocusNode,
          onFieldSubmitted: (value) {
            Utils.changeFocusNode(context, nameFocusNode, emailFocusNode);
          },
          controller: _namecontroller,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.person), hintText: "Name"),
        ),
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
              text: "Signup",
              onPress: () {
                if (_emailcontroller.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please Enter Email", context);
                }

                // if (!(_passwordcontroller.text.length > 5)) {
                //   Utils.flushBarErrorMessage(
                //       "Please enter proper password", context);
                // }
                else {
                  Map data = {
                    'name': _namecontroller.text.toString(),
                    'email': _emailcontroller.text.trim().toString(),
                    'password': _passwordcontroller.text.toString()
                  };
                  authViewModel.signup(data, context);
                }
              },
              loading: value.loading,
            );
          },
        ),
        SizedBox(
          height: 0.05 * height,
        ),
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.loginscreen);
            },
            child: const Text("Already have a account ? Login Now"))
      ],
    )));
  }
}
