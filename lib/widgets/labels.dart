import 'package:flutter/material.dart';

class CustomLabels extends StatelessWidget {
  const CustomLabels({Key? key, required this.ruta, required this.text})
      : super(key: key);

  final String text;
  final String ruta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(text))
      ],
    );
  }
}
