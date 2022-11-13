abstract class ProfileScreenStates {}

class InitProfileScreenState extends ProfileScreenStates {}

class LoadingGetProfileState extends ProfileScreenStates {}

class SuccessGetProfileState extends ProfileScreenStates {}

class ErrorGetProfileState extends ProfileScreenStates {
  String? error;
  ErrorGetProfileState({this.error});
}
