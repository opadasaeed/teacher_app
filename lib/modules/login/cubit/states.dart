abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {}

class SuccessGoogleLoginState extends LoginStates {}

class SuccessFacebookLoginState extends LoginStates {}

class ErrorLoginState extends LoginStates {
  String? error;
  ErrorLoginState({this.error});
}

class ChangeState extends LoginStates {}
