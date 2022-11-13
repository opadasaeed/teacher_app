import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/layout/home/home_layout.dart';
import 'package:teacher_app/modules/login/cubit/cubit.dart';
import 'package:teacher_app/modules/login/cubit/states.dart';
import 'package:teacher_app/modules/signUp/sign_up_screen.dart';
import 'package:teacher_app/shared/components/default_button.dart';
import 'package:teacher_app/shared/components/default_text_form_field.dart';
import 'package:teacher_app/shared/components/loading_dialog.dart';
import 'package:teacher_app/shared/components/toasts.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:teacher_app/shared/di/di.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';
import 'package:showcaseview/showcaseview.dart';

import '../forgotPassword/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is SuccessLoginState) {
            navigateAndFinish(
              context: context,
              route: ShowCaseWidget(
                onFinish: () async => await UserHelper.putShowCases(true),
                builder: Builder(builder: (context) => HomeLayout()),
              ),
            );
          }
          if (state is SuccessGoogleLoginState) {
            Navigator.pop(context);

            navigateTo(
              context: context,
              route: SignUpScreen(
                email: LoginCubit.get(context).user.user!.email,
                name: LoginCubit.get(context).user.user!.displayName,
                phoneNumber: LoginCubit.get(context).user.user!.phoneNumber,
              ),
            );
          }
          if (state is SuccessFacebookLoginState) {
            Navigator.pop(context);
            navigateTo(
              context: context,
              route: SignUpScreen(
                email: LoginCubit.get(context).user.user!.email,
                name: LoginCubit.get(context).user.user!.displayName,
                phoneNumber: LoginCubit.get(context).user.user!.phoneNumber,
              ),
            );
          }
          if (state is LoadingLoginState) {
            LoadingDialog().show();
          }
          if (state is ErrorLoginState) {
            showToast(msg: translate(LocalKeys.userExp.informationErrorMsg));
          }
        },
        builder: (BuildContext context, state) {
          emailFocusNode.addListener(() {
            LoginCubit.get(context)
                .changeEmailTextFieldColor(hasFocus: emailFocusNode.hasFocus);
          });
          passwordFocusNode.addListener(() {
            LoginCubit.get(context).changePasswordTextFieldColor(
                hasFocus: passwordFocusNode.hasFocus);
          });
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translate(
                                LocalKeys.userExp.signIn,
                              ),
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translate(
                                      LocalKeys.userExp.phoneNumber,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: ThemeCubit.get(context).isDark!
                                              ? Colors.white
                                              : const Color(
                                                  0xFF9196A8,
                                                ),
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  DefaultTextFormField(
                                    textInputType: TextInputType.number,
                                    isValidate: true,
                                    focusNode: emailFocusNode,
                                    hasFocused:
                                        LoginCubit.get(context).emailFocused,
                                    hintTitle: translate(
                                      LocalKeys.userExp.phoneNumberHint,
                                    ),
                                    controller: emailController,
                                    title: translate(
                                      LocalKeys.userExp.phoneNumber,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translate(
                                      LocalKeys.userExp.password,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: ThemeCubit.get(context).isDark!
                                              ? Colors.white
                                              : const Color(
                                                  0xFF9196A8,
                                                ),
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  DefaultTextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '${translate(LocalKeys.userExp.youMustEnter)} ${translate(
                                          LocalKeys.userExp.password,
                                        )}';
                                      } else if (value.length < 8) {
                                        return translate(LocalKeys
                                            .userExp.passwordVerification);
                                      }
                                    },
                                    focusNode: passwordFocusNode,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    isValidate: true,
                                    obscureText: true,
                                    hasFocused:
                                        LoginCubit.get(context).passwordFocused,
                                    hintTitle: translate(
                                      LocalKeys.userExp.passwordHint,
                                    ),
                                    controller: passwordController,
                                    title: translate(
                                      LocalKeys.userExp.password,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateTo(
                                  context: context,
                                  route: const ForgotPasswordScreen(),
                                );
                              },
                              child: Text(
                                translate(
                                  LocalKeys.userExp.forgotPassword,
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: const Color(0xFF03D8CE),
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        DefaultButton(
                          btColor: AppColors.buttonColor,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              LoginCubit.get(context).login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                            /*  navigateAndFinish(
                                context: context,
                                route: HomeLayout(),
                              ); */
                          },
                          title: translate(
                            LocalKeys.userExp.signIn,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),

                        // if(Platform.isIOS)
                        // Container(
                        //   width: double.infinity,
                        //   height: 52,
                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12.0),
                        //     boxShadow: const [
                        //       BoxShadow(
                        //         offset: Offset(0.0, 0.4),
                        //         color: Color.fromRGBO(0, 0, 0, 0.2),
                        //         blurRadius: 20,
                        //       ),
                        //     ],
                        //     color: Colors.black,
                        //   ),
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 18,
                        //   ),
                        //   child: TextButton(
                        //     onPressed: () async {
                        //       final credential =
                        //           await SignInWithApple.getAppleIDCredential(
                        //         scopes: [
                        //           AppleIDAuthorizationScopes.email,
                        //           AppleIDAuthorizationScopes.fullName,
                        //         ],
                        //       );
                        //       if (credential.authorizationCode != null) {
                        //         navigateTo(
                        //           context: context,
                        //           route: SignUpScreen(
                        //             email: credential.email,
                        //             name: credential.givenName,
                        //           ),
                        //         );
                        //       }
                        //     },
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         SvgPicture.asset(
                        //           'assets/icons/apple.svg',
                        //           matchTextDirection: false,
                        //           width: 24,
                        //         ),
                        //         Text(
                        //           translate(
                        //             LocalKeys.userExp.appleLogin,
                        //           ),
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .bodyText2
                        //               .copyWith(
                        //                 fontWeight: FontWeight.w400,
                        //                 color: Colors.white,
                        //               ),
                        //         ),
                        //         const SizedBox(
                        //           width: 12,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        if (Platform.isAndroid)
                          const SizedBox(
                            height: 80,
                          ),
                        Text(
                          translate(
                            LocalKeys.userExp.haveAccount,
                          ),
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: ThemeCubit.get(context).isDark!
                                        ? Colors.white
                                        : const Color(
                                            0xFF9196A8,
                                          ),
                                    fontWeight: FontWeight.w100,
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextButton(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          onPressed: () {
                            navigateTo(
                              context: context,
                              route: SignUpScreen(),
                            );
                          },
                          child: Text(
                            translate(
                              LocalKeys.userExp.signNow,
                            ),
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: const Color(
                                        0xFF03D8CE,
                                      ),
                                      fontWeight: FontWeight.w100,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // if (state is LoadingLoginState)
                // Container(
                //   color: Colors.white,
                //   child: Padding(
                //     padding: const EdgeInsets.all(12.0),
                //     child: CircularProgressIndicator(
                //       color: AppColors.primary1Color,
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
