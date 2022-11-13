import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/modules/forgotPassword/cubit/cubit.dart';
import 'package:teacher_app/modules/forgotPassword/cubit/states.dart';
import 'package:teacher_app/shared/components/default_button.dart';
import 'package:teacher_app/shared/components/default_text_form_field.dart';
import 'package:teacher_app/shared/components/dialogs/loading_dialog.dart';
import 'package:teacher_app/shared/components/toasts.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';

import '../../shared/components/dialogs/success_dialog.dart';
import '../../shared/di/di.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FocusNode emailFocusNode = FocusNode();
  bool hasFocus = false;
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        hasFocus = true;
        setState(() {});
      } else {
        hasFocus = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<ForgetPasswordCubit>(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text(
                              translate(
                                LocalKeys.userExp.forgotPassword,
                              ),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Image.asset(
                          'assets/images/forgotPassword.png',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          translate(
                            LocalKeys.userExp.enterYourEmailToReset,
                          ),
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                fontWeight: FontWeight.w200,
                              ),
                        ),
                        Text(
                          translate(
                            LocalKeys.userExp.yourPassword,
                          ),
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                fontWeight: FontWeight.w200,
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate(
                                LocalKeys.userExp.email,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: const Color(
                                      0xFF9196A8,
                                    ),
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            DefaultTextFormField(
                              textInputType: TextInputType.emailAddress,
                              isValidate: true,
                              focusNode: emailFocusNode,
                              hasFocused: hasFocus,
                              hintTitle: translate(
                                LocalKeys.userExp.emailHint,
                              ),
                              controller: emailController,
                              title: translate(
                                LocalKeys.userExp.email,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 90,),
                        DefaultButton(
                          function: () {
                            ForgetPasswordCubit.get(context).resetPassword(
                                email: emailController.text ?? '');
                          },
                          title: translate(
                            LocalKeys.userExp.next,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, state) {
          if (state is LoadingForgetPasswordState) {
            showLoadingDialog(context);
          } else if (state is SuccessForgetPasswordState) {
            Navigator.pop(context);
            showSuccessResetPasswordDialog(context)
                .then((value) => Navigator.pop(context));
          } else if (state is ErrorForgetPasswordState) {
            Navigator.pop(context);
            showToast(msg: "حدث خطا يرجى المحاولة مرة اخرى");
          }
        },
      ),
    );
  }
}
