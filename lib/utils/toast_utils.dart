import 'package:flutter/material.dart';

class ToastUtils {
  static bool _isShowing = false;
  static void showToast(BuildContext context, String? message) {
    if (_isShowing) return;
    _isShowing = true;
    Future.delayed(Duration(seconds: 3), () {
      _isShowing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        backgroundColor: Color.fromRGBO(128, 128, 128, 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: Text(
          message ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
