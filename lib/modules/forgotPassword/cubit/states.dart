abstract class ForgetPasswordStates {}

class InitForgetPasswordState extends ForgetPasswordStates {}

class LoadingForgetPasswordState extends ForgetPasswordStates {}

class SuccessForgetPasswordState extends ForgetPasswordStates {}

class ErrorForgetPasswordState extends ForgetPasswordStates {
  String? error;
  ErrorForgetPasswordState({this.error});
}

