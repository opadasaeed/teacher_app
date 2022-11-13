import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      fontSize: 18,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.grey.shade300,
      textColor: Colors.black,
      gravity: ToastGravity.TOP);
}

void toastConnectionError() {
  Fluttertoast.showToast(msg: 'خطأ فى الإتصال بالخادم، أعد المحاولة لاحقًا');
}

void toastInvalidInformation() {
  Fluttertoast.showToast(msg: 'معلومات غير صحيحة');
}
