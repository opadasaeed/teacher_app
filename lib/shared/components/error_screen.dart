import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/animations/error.json',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: Text(
                      translate(LocalKeys.userExp.networlError),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.withOpacity(.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            28.0,
      ),
    );
  }
}
