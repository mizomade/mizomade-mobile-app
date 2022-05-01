import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUtils {
  CustomUtils._();
  static errorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.shade600,
        content: Text("$message"),
      ),
    );
  }
  static successSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),

        backgroundColor: Colors.green.shade600,

        content: Text("$message"),
      ),
    );
  }

  static infoSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),

        content: Text("$message"),
      ),
    );
  }
}