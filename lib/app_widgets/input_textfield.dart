import 'package:flutter/material.dart';

/// UI Class to create a unified type of input field for the app
class InputTextField extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final bool enabledTextField;
  final String hintText;
  final String labelText;
  final IconData icon;
  final double marginVertical;
  final double marginHorizontal;
  final bool obfuscatedText;

  InputTextField({
    required this.width,
    required this.height,
    required this.controller,
    required this.enabledTextField,
    required this.icon,
    this.hintText = '',
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.obfuscatedText = false,
    required this.labelText,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      width: width,
      height: height,
      child: TextField(
        obscureText: obfuscatedText,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        enabled: enabledTextField,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
