import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/layout/home/home_layout.dart';
import 'package:teacher_app/modules/signUp/cubit/cubit.dart';
import 'package:teacher_app/modules/signUp/cubit/states.dart';
import 'package:teacher_app/shared/components/default_button.dart';
import 'package:teacher_app/shared/components/default_text_form_field.dart';
import 'package:teacher_app/shared/components/loading_dialog.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:teacher_app/shared/di/di.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../shared/components/toasts.dart';

class SignUpScreen extends StatelessWidget {
  final String? email;
  final String? name;
  final String? phoneNumber;

  SignUpScreen({Key? key, this.email, this.name, this.phoneNumber})
      : super(key: key);

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode parentPhoneNumberFocusNode = FocusNode();
  final FocusNode nationalIdFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode fullNameFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController parentPhoneNumberController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    emailController.text = email ?? '';
    fullNameController.text = name ?? '';
    phoneNumberController.text = phoneNumber ?? '';
    String gender = 'm';
    int classRoom = 1;

    return BlocProvider(
      create: (BuildContext context) => di<SignUpCubit>(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (BuildContext context, state) {
          if (state is SuccessSignUpState) {
            Navigator.pop(context);
            navigateAndFinish(
              context: context,
              route: ShowCaseWidget(
                onFinish: () async => await UserHelper.putShowCases(true),
                builder: Builder(builder: (context) => HomeLayout()),
              ),
            );
          }
          if (state is LoadingSignUpState) {
            LoadingDialog().show();
          }
          if (state is ErrorSignUpState) {
            Navigator.pop(context);
            showToast(msg: translate(LocalKeys.userExp.verfayError));
          }
        },
        builder: (BuildContext context, state) {
          emailFocusNode.addListener(() {
            SignUpCubit.get(context)
                .changeEmailTextFieldColor(hasFocus: emailFocusNode.hasFocus);
          });
          passwordFocusNode.addListener(() {
            SignUpCubit.get(context).changePasswordTextFieldColor(
                hasFocus: passwordFocusNode.hasFocus);
          });
          fullNameFocusNode.addListener(() {
            SignUpCubit.get(context).changeFullNameTextFieldColor(
                hasFocus: fullNameFocusNode.hasFocus);
          });
          phoneNumberFocusNode.addListener(() {
            SignUpCubit.get(context).changePhoneNumberTextFieldColor(
                hasFocus: phoneNumberFocusNode.hasFocus);
          });
          parentPhoneNumberFocusNode.addListener(() {
            SignUpCubit.get(context).changeParentPhoneNumberTextFieldColor(
                hasFocus: parentPhoneNumberFocusNode.hasFocus);
          });
          addressFocusNode.addListener(() {
            SignUpCubit.get(context).changeAddressTextFieldColor(
                hasFocus: addressFocusNode.hasFocus);
          });
          return WillPopScope(
            onWillPop: () async {
              await SignUpCubit.get(context).socialSignOut(context);
              Navigator.pop(context);
              return true;
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                              onPressed: () {
                                SignUpCubit.get(context).socialSignOut(context);
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Text(
                              translate(
                                LocalKeys.userExp.signUp,
                              ),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          translate(
                            LocalKeys.userExp.signUpWarning,
                          ),
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.red,
                                  ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translate(
                                  LocalKeys.userExp.fullName,
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
                                textInputType: TextInputType.name,
                                isValidate: true,
                                focusNode: fullNameFocusNode,
                                hasFocused:
                                    SignUpCubit.get(context).fullNameFocused,
                                hintTitle: translate(
                                  LocalKeys.userExp.fullNameHint,
                                ),
                                controller: fullNameController,
                                title: translate(
                                  LocalKeys.userExp.fullName,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              if (!Platform.isIOS) ...[
                                Text(
                                  translate(
                                    LocalKeys.userExp.nationalId,
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
                                        LocalKeys.userExp.nationalId,
                                      )}';
                                    } else if (value.length < 13) {
                                      return translate(LocalKeys
                                          .userExp.nationalIdVerification);
                                    }
                                  },
                                  textInputType: TextInputType.number,
                                  isValidate: true,
                                  focusNode: nationalIdFocusNode,
                                  hasFocused: SignUpCubit.get(context)
                                      .nationalIdFocused,
                                  hintTitle: translate(
                                    LocalKeys.userExp.nationalIdHint,
                                  ),
                                  controller: nationalIdController,
                                  title: translate(
                                    LocalKeys.userExp.nationalId,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${translate(LocalKeys.userExp.youMustEnter)} ${translate(
                                      LocalKeys.userExp.phoneNumber,
                                    )}';
                                  } else if (value.length != 11) {
                                    return translate(
                                        LocalKeys.userExp.phoneVerification);
                                  }
                                },
                                textInputType: TextInputType.phone,
                                isValidate: true,
                                focusNode: phoneNumberFocusNode,
                                hasFocused:
                                    SignUpCubit.get(context).phoneNumberFocused,
                                hintTitle: translate(
                                  LocalKeys.userExp.phoneNumberHint,
                                ),
                                controller: phoneNumberController,
                                title: translate(
                                  LocalKeys.userExp.phoneNumber,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                translate(
                                  LocalKeys.userExp.parentPhoneNumber,
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
                                      LocalKeys.userExp.parentPhoneNumber,
                                    )}';
                                  } else if (value.length != 11) {
                                    return translate(
                                        LocalKeys.userExp.phoneVerification);
                                  } else if (value ==
                                      phoneNumberController.text) {
                                    return translate(
                                        LocalKeys.userExp.parentPhoneError);
                                  }
                                },
                                textInputType: TextInputType.phone,
                                isValidate: true,
                                focusNode: parentPhoneNumberFocusNode,
                                hasFocused: SignUpCubit.get(context)
                                    .parentPhoneNumberFocused,
                                hintTitle: translate(
                                  LocalKeys.userExp.parentPhoneNumberHint,
                                ),
                                controller: parentPhoneNumberController,
                                title: translate(
                                  LocalKeys.userExp.parentPhoneNumber,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                translate(
                                  LocalKeys.userExp.address,
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
                                textInputType: TextInputType.streetAddress,
                                isValidate: true,
                                focusNode: addressFocusNode,
                                hasFocused:
                                    SignUpCubit.get(context).addressFocused,
                                hintTitle: translate(
                                  LocalKeys.userExp.addressHint,
                                ),
                                controller: addressController,
                                title: translate(
                                  LocalKeys.userExp.address,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                translate(
                                  LocalKeys.userExp.email,
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
                                textInputType: TextInputType.emailAddress,
                                isValidate: true,
                                focusNode: emailFocusNode,
                                hasFocused:
                                    SignUpCubit.get(context).emailFocused,
                                hintTitle: translate(
                                  LocalKeys.userExp.emailHint,
                                ),
                                controller: emailController,
                                title: translate(
                                  LocalKeys.userExp.email,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
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
                                    return translate(
                                        LocalKeys.userExp.passwordVerification);
                                  }
                                },
                                focusNode: passwordFocusNode,
                                textInputType: TextInputType.visiblePassword,
                                isValidate: true,
                                obscureText: true,
                                hasFocused:
                                    SignUpCubit.get(context).passwordFocused,
                                hintTitle: translate(
                                  LocalKeys.userExp.passwordHint,
                                ),
                                controller: passwordController,
                                title: translate(
                                  LocalKeys.userExp.password,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if(!Platform.isIOS)...[ Text(
                                translate(
                                  LocalKeys.userExp.gender,
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
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: DropdownSearch<String>(
                                    mode: Mode.BOTTOM_SHEET,
                                    showSelectedItems: true,
                                    items: [
                                      translate(
                                        LocalKeys.userExp.male,
                                      ),
                                      translate(
                                        LocalKeys.userExp.female,
                                      ),
                                    ],
                                    dropdownSearchDecoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      fillColor: ThemeCubit.get(context).isDark!
                                          ? const Color(0xFF2C2E37)
                                          : const Color(0xFFF5F5F9),
                                      filled: true,
                                      focusColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF6676E1),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value ==
                                          translate(LocalKeys.userExp.female)) {
                                        gender = 'f';
                                      } else {
                                        gender = 'm';
                                      }
                                    },
                                    selectedItem: gender == 'm'
                                        ? translate(
                                      LocalKeys.userExp.male,
                                    )
                                        : translate(LocalKeys.userExp.female),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),],

                              Text(
                                translate(
                                  LocalKeys.userExp.grade,
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
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownSearch<String>(
                                  mode: Mode.BOTTOM_SHEET,
                                  showSelectedItems: true,
                                  items: [
                                    translate(
                                      LocalKeys.userExp.firstSecondaryGrade,
                                    ),
                                    translate(
                                      LocalKeys.userExp.secondSecondaryGrade,
                                    ),
                                    translate(
                                      LocalKeys.userExp.thirdSecondaryGrade,
                                    ),
                                  ],
                                  dropdownSearchDecoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    fillColor: ThemeCubit.get(context).isDark!
                                        ? const Color(0xFF2C2E37)
                                        : const Color(0xFFF5F5F9),
                                    filled: true,
                                    focusColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6676E1),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value ==
                                        translate(
                                          LocalKeys.userExp.firstSecondaryGrade,
                                        )) {
                                      classRoom = 1;
                                    } else if (value ==
                                        translate(
                                          LocalKeys
                                              .userExp.secondSecondaryGrade,
                                        )) {
                                      classRoom = 2;
                                    } else {
                                      classRoom = 3;
                                    }
                                    SignUpCubit.get(context)
                                        .showDivisionWidget(grade: value!);
                                  },
                                  selectedItem: translate(
                                    LocalKeys.userExp.firstSecondaryGrade,
                                  ),
                                ),
                              ),
                              if (SignUpCubit.get(context).showDivision ||
                                  SignUpCubit.get(context).showThirdDivision)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      translate(
                                        LocalKeys.userExp.division,
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
                                    if (SignUpCubit.get(context).showDivision)
                                      Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: DropdownSearch<String>(
                                          mode: Mode.BOTTOM_SHEET,
                                          showSelectedItems: true,
                                          items: [
                                            translate(
                                              LocalKeys
                                                  .userExp.scientificDivision,
                                            ),
                                            translate(
                                              LocalKeys
                                                  .userExp.literaryDivision,
                                            ),
                                          ],
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            fillColor:
                                                ThemeCubit.get(context).isDark!
                                                    ? const Color(0xFF2C2E37)
                                                    : const Color(0xFFF5F5F9),
                                            filled: true,
                                            focusColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFF6676E1),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                            ),
                                          ),
                                          onChanged: print,
                                          selectedItem: translate(
                                            LocalKeys
                                                .userExp.scientificDivision,
                                          ),
                                        ),
                                      ),
                                    if (SignUpCubit.get(context)
                                        .showThirdDivision)
                                      Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: DropdownSearch<String>(
                                          mode: Mode.BOTTOM_SHEET,
                                          showSelectedItems: true,
                                          items: [
                                            // translate(
                                            //   LocalKeys.userExp.scientificDivision,
                                            // ),
                                            // translate(
                                            //   LocalKeys.userExp.literaryDivision,
                                            // ),
                                            'علمى - رياضة',
                                            'علمى - علوم',
                                            'ادبى',
                                          ],
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            fillColor: const Color(0xFFF5F5F9),
                                            filled: true,
                                            focusColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFF6676E1),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                            ),
                                          ),
                                          onChanged: print,
                                          selectedItem: 'علمى - رياضة',
                                        ),
                                      ),
                                  ],
                                ),
                              const SizedBox(
                                height: 40,
                              ),
                              DefaultButton(
                                btColor: AppColors.buttonColor,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    SignUpCubit.get(context).signUp(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: fullNameController.text,
                                        nationalId: nationalIdController.text,
                                        phone: phoneNumberController.text,
                                        parentPhone:
                                            parentPhoneNumberController.text,
                                        address: addressController.text,
                                        gender: gender,
                                        classRoom: classRoom);
                                  }
                                },
                                title: translate(
                                  LocalKeys.userExp.signNow,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
