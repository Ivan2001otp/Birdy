import 'package:flutter/material.dart';

class CA_Button extends StatelessWidget {
  final VoidCallback onpressed;
  final Color? bgColor;
  final Widget btnText;

  const CA_Button({
    required this.btnText,
    this.bgColor,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Colors.deepPurple,
        ),
        onPressed: onpressed,
        child: btnText);
  }
}
