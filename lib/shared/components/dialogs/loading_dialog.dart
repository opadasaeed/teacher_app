import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../local/localization/local_keys.dart';
import '../loader_indecator.dart';


Future<void> showLoadingDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10.0,
        title: Center(
          child: Text(
            translate(
              LocalKeys.userExp.pleaseWait,
            ),
          ),
        ),
        content: Container(height: 150, child: const LoadingIndecator()),
        contentPadding: EdgeInsets.zero,
      );
    },
  );
}
