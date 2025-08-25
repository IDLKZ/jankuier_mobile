import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToaster {
  static void showError(
    String message, {
    Toast? toastLength = Toast.LENGTH_LONG,
    ToastGravity? gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showInfo(
    String message, {
    Toast? toastLength = Toast.LENGTH_LONG,
    ToastGravity? gravity = ToastGravity.CENTER,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSuccess(
    String message, {
    Toast? toastLength = Toast.LENGTH_LONG,
    ToastGravity? gravity = ToastGravity.CENTER,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showWarning(
    String message, {
    Toast? toastLength = Toast.LENGTH_LONG,
    ToastGravity? gravity = ToastGravity.CENTER,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
