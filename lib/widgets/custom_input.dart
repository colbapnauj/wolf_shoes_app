import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.labelText,
    required this.keyboardType,
    this.obscureText,
  }) : super(key: key);

  final String labelText;
  final TextInputType keyboardType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        keyboardType: keyboardType,
        autocorrect: false,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Color(0xff2b2b2b),
              fontSize: 20,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
