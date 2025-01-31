import 'package:flutter/material.dart';

class UnexpectedErrorAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function()? onPressed;

  const UnexpectedErrorAlertDialog({ super.key, required this.title, required this.message, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[ Text(message),
                                const Text('Por favor, contate a equipe INTEGRAZOO.') ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text('Fechar')
          )
        ]
      );
  }
}