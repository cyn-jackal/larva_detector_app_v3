import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

ConfirmDialog(String message, BuildContext context, method) async {
  if (await confirm(context,
      title: Text(message),
      textOK: Text(
        "Ok",
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      textCancel: Text(
        "Cancle",
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ))) {
    method();
    return print('pressOK');
  }
  return print('pressedCancel');
}
