import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teacher_app/modules/phoneVerification/phone_verification_screen.dart';
import 'package:teacher_app/modules/signUp/cubit/states.dart';
import 'package:teacher_app/modules/signUp/models/sign_up_model.dart';
import 'package:teacher_app/shared/components/toasts.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/network/repository.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  final Repository repository;
  SignUpCubit(this.repository) : super(InitialSignUpState());
  static SignUpCubit get(context) => BlocProvider.of(context);
  SignUpModel signUpModel = SignUpModel();
  bool emailFocused = false;
  bool passwordFocused = false;
  bool phoneNumberFocused = false;
  bool parentPhoneNumberFocused = false;
  bool addressFocused = false;
  bool fullNameFocused = false;
  bool nationalIdFocused = false;
  bool showDivision = false;
  bool showThirdDivision = false;
  showDivisionWidget({required String grade}) {
    if (grade == translate(LocalKeys.userExp.firstSecondaryGrade)) {
      showDivision = false;
      showThirdDivision = false;
      emit(ChangeState());
    } else if (grade == translate(LocalKeys.userExp.thirdSecondaryGrade)) {
      showThirdDivision = true;
      showDivision = false;
      emit(ChangeState());
    } else {
      showDivision = true;
      showThirdDivision = false;
      emit(ChangeState());
    }
  }

  changeEmailTextFieldColor({required bool hasFocus}) {
    if (hasFocus) {
      emailFocused = true;
      emit(ChangeState());
    } else {
      emailFocused = false;
      emit(ChangeState());
    }
  }

  changePasswordTextFieldColor({required bool hasFocus}) {
    if (hasFocus) {
      passwordFocused = true;
      emit(ChangeState());
    } else {
      passwordFocused = false;
      emit(ChangeState());
    }
  }

  changePhoneNumberTextFieldColor({required bool hasFocus}) {
    if (hasFocus) {
      phoneNumberFocused = true;
      emit(ChangeState());
    } else {
      phoneNumberFocused = false;
      emit(ChangeState());
    }
  }

  changeParentPhoneNumberTextFieldColor({required bool hasFocus}) {
    if (hasFocus) {
      parentPhoneNumberFocused = true;
      emit(ChangeState());
    } else {
      parentPhoneNumberFocused = false;
      emit(ChangeState());
    }
  }

  changeAddressTextFieldColor({required bool hasFocus}) {
    if (hasFocus) {
      addressFocused = true;
      emit(ChangeState());
    } else {
      addressFocused = false;
      emit(ChangeState());
    }
  }

  changeFullNameTextFieldColor({required bool hasFocus}) {
    if (hasFocus) {
      fullNameFocused = true;
      emit(ChangeState());
    } else {
      fullNameFocused = false;
      emit(ChangeState());
    }
  }

  changeNationalIdTextFieldColor({required bool hasFocus}) {
    if (hasFocus) {
      nationalIdFocused = true;
      emit(ChangeState());
    } else {
      nationalIdFocused = false;
      emit(ChangeState());
    }
  }

  Future<void> socialSignOut(context) async {
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    } else if (await FacebookLogin().isLoggedIn) {
      await FacebookLogin().logOut();
    }
  }

  phoneVerification({
    String? phone,
    context,
    String? name,
    String? parentPhone,
    String? address,
    String? email,
    String? nationalId,
    String? password,
    String? gender,
    int? classRoom,
    int? devisionId,
  }) async {
    bool verified = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PhoneVerificationScreen(
              phone: phone ?? '',
            )));

    if (verified) {
      SignUpCubit.get(context).signUp(
          email: email!,
          password: password!,
          name: name!,
          phone: phone!,
          nationalId: nationalId!,
          parentPhone: parentPhone!,
          address: address!,
          gender: gender!,
          classRoom: classRoom!);
    } else {
      showToast(msg: translate(LocalKeys.userExp.verfayError));
    }
  }

  void signUp({
    String? name,
    String? phone,
    String? parentPhone,
    String? nationalId,
    String? address,
    String? email,
    String? password,
    String? gender,
    int? classRoom,
    int? devisionId,
  }) async {
    emit(LoadingSignUpState());
    final f = await repository.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        parentPhone: parentPhone,
        address: address,
        classRoom: classRoom,
        nationalId: nationalId,
        gender: gender);
    f.fold(
          (l) async {
        emit(ErrorSignUpState(error: l));
      },
          (r) async {
        signUpModel = r;
        if (r.success==true) {
          UserHelper.putUserToken(r.data!.token!);
          UserHelper.putWallet(r.data!.wallet.toString());
          await UserHelper.putUserModel(signUpModel);
          await UserHelper.putUserId(signUpModel.data!.email);
          saveDeviceToken();
          emit(SuccessSignUpState());
        } else {
          emit(ErrorSignUpState());
        }
      },
    );
  }
}