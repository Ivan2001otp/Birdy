import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final Color Bgcolor;
  final Color textColor;

  const CustomToast({
    required this.message,
    this.textColor = Colors.white,
    this.Bgcolor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
