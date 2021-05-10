import 'package:flutter/material.dart';

void showError(String error, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(error),
    backgroundColor: Theme.of(context).errorColor,
  ));
}
