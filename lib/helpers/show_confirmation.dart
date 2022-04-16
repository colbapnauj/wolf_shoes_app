import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarConfirmacion(BuildContext context, String titulo, String subtitulo,
    Function() onPressed) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: <Widget>[
          CupertinoButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoButton(child: const Text('Eliminar'), onPressed: onPressed),
        ],
      );
    },
  );
}
