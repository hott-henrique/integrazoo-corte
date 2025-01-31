import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;

  const Button({ super.key, required this.text, required this.onPressed, required this.color });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(backgroundColor: WidgetStateProperty.all(color)),
      onPressed: onPressed,
      child: Text(text)
    );
  }
}
