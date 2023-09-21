import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String text;
  bool loading;
  final VoidCallback onPress;

  RoundButton(
      {required this.loading, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 124, 82, 82),
              borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: double.infinity,
          child: Center(
            child: loading ? const CircularProgressIndicator() : Text(text),
          ),
        ),
      ),
    );
  }
}
