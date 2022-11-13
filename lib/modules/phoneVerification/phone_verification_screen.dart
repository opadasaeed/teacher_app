import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/shared/components/default_button.dart';
import 'package:teacher_app/shared/components/loading_dialog.dart';
import 'package:teacher_app/shared/components/toasts.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key, this.phone}) : super(key: key);
  final String? phone;

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController authCodeController = TextEditingController();
  late String verficationCode;
  int start = 30;
  bool wait = true;
  final FocusNode authCodeFocusNode = FocusNode();
  @override
  void initState() {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2${widget.phone}',
      verificationCompleted: (credential) {},
      timeout: const Duration(seconds: 60),
      verificationFailed: (FirebaseAuthException e) {
        startTimer();

        showToast(msg: e.message!);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          verficationCode = verificationId;
          startTimer();
        });
      },
    );

    super.initState();
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    if (mounted) {
      Timer.periodic(onsec, (timer) {
        if (mounted) {
          if (start == 0) {
            setState(() {
              timer.cancel();
              wait = false;
            });
          } else {
            setState(() {
              start--;
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                  Text(
                    translate(
                      LocalKeys.userExp.verification,
                    ),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    translate(
                      LocalKeys.userExp.enterPhoneCode,
                    ),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '+2 ${widget.phone}',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColors.primary1Color,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 56,
                        fieldWidth: 56,
                        borderWidth: 1,
                        activeFillColor: Colors.white,
                        selectedColor: AppColors.primary1Color,
                        inactiveColor: const Color(0xFF979797),
                        activeColor: AppColors.primary1Color,
                      ),
                      textStyle: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                      cursorColor: AppColors.primary1Color,
                      autoFocus: true,
                      cursorHeight: 32,
                      animationDuration: const Duration(milliseconds: 300),
                      controller: authCodeController,
                      focusNode: authCodeFocusNode,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${translate(
                          LocalKeys.userExp.resendCode,
                        )} $start',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: const Color(0xFF03D8CE),
                              fontWeight: FontWeight.w200,
                            ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        onPressed: wait
                            ? null
                            : () async {
                                setState(() {
                                  start = 30;

                                  wait = true;
                                });
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: '+2${widget.phone}',
                                  verificationCompleted: (credential) {
                                    startTimer();
                                  },
                                  verificationFailed:
                                      (FirebaseAuthException e) {
                                    startTimer();

                                    showToast(msg: e.message!);
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                  codeSent: (String verificationId,
                                      int? forceResendingToken) {
                                    if (mounted) {
                                      setState(() {
                                        verficationCode = verificationId;
                                        startTimer();
                                      });
                                    }
                                  },
                                );
                              },
                        child: Text(
                          translate(
                            LocalKeys.userExp.resend,
                          ),
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                color: wait
                                    ? AppColors.neutral2Color
                                    : AppColors.primary1Color,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  DefaultButton(
                    function: () async {
                      LoadingDialog().show();
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: verficationCode,
                              smsCode: authCodeController.text ?? '');

                      Navigator.pop(context);
                      await FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) {
                        Navigator.pop(context, true);
                      }).catchError((error) {
                        showToast(msg: 'code not valid');
                      });
                    },
                    title: translate(
                      LocalKeys.userExp.next,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
