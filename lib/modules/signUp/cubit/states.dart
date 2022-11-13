abstract class SignUpStates{}
class InitialSignUpState extends SignUpStates{}
class ChangeState extends SignUpStates{}
class LoadingSignUpState extends SignUpStates {}

class SuccessSignUpState extends SignUpStates {}

class ErrorSignUpState extends SignUpStates {
  String? error;
  ErrorSignUpState({this.error});
}