import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/shared/components/default_button.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';


Future<void> showSuccessDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10.0,
        title: Center(
          child: Text(
            translate(
              LocalKeys.userExp.success,
            ),
          ),
        ),
        content: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 12,
          ),
          child: Image.asset(
            'assets/images/success.png',
            height: 120.0,
          ),
        ),
        actions: [
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: DefaultButton(
              title: translate(
                LocalKeys.userExp.ok,
              ),
              function: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
        contentPadding: EdgeInsets.zero,
      );
    },
  );
}
Future<void> showSuccessResetPasswordDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10.0,
        title: Center(
          child: Text(
           'تم ارسال رسالة اليك على الايميل المسجل به لدينا لاعادة تعيين كلمة المرور'
          ),
        ),
        content: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 12,
          ),
          child: Image.asset(
            'assets/images/success.png',
            height: 120.0,
          ),
        ),
        actions: [
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: DefaultButton(
              title: translate(
                LocalKeys.userExp.ok,
              ),
              function: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
        contentPadding: EdgeInsets.zero,
      );
    },
  );
}
