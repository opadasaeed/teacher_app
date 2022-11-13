import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher_app/modules/login/cubit/states.dart';
import 'package:teacher_app/modules/login/models/login_model.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/network/repository.dart';

class LoginCubit extends Cubit<LoginStates> {
  final Repository? repository;
  LoginCubit(this.repository) : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool emailFocused = false;
  bool passwordFocused = false;
  LoginModel loginModel = LoginModel();
  late UserCredential user;

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

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoadingLoginState());
    final f = await repository!.login(
      email: email,
      password: password,
    );
    f.fold(
      (l) async {
        emit(ErrorLoginState(error: l));
      },
      (r) async {
        loginModel = r;
        if (r.success!) {
          // cache user access token
          // print(r.data.token);
          UserHelper.putUserToken(r.data!.token);
          UserHelper.putWallet(r.data!.wallet.toString());
          await UserHelper.putUserModel(loginModel);
          await UserHelper.putUserId(loginModel.data!.email);
          saveDeviceToken();
          emit(SuccessLoginState());
          storeDeviceUid(r.data!.email!);
        } else {
          emit(ErrorLoginState());
        }
      },
    );
  }

  void googleLogIn() async {
    emit(LoadingLoginState());
    final f = await repository!.loginWithGoogle();
    f.fold((l) async {
      emit(ErrorLoginState(error: l));
    }, (r) {
      user = r;
      if (r.user!.uid != null) {
        emit(SuccessGoogleLoginState());
      } else {
        emit(ErrorLoginState());
      }
    });
  }

  void facebookLogIn() async {
    emit(LoadingLoginState());
    final f = await repository!.loginWithFacebook();
    f.fold((l) async {
      emit(ErrorLoginState(error: l));
    }, (r) {
      user = r;
      if (r.user!.uid != null) {
        emit(SuccessFacebookLoginState());
      } else {
        emit(ErrorLoginState());
      }
    });
  }
}
