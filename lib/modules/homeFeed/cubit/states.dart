abstract class HomeFeedScreenStates {}

class InitHomeFeedScreenState extends HomeFeedScreenStates {}

class LoadingGetHomeFeedState extends HomeFeedScreenStates {}

class SuccessGetHomeFeedState extends HomeFeedScreenStates {}
class BackHomeFeedState extends HomeFeedScreenStates {}

class ErrorGetHomeFeedState extends HomeFeedScreenStates {
  String? error;
  ErrorGetHomeFeedState({this.error});
}

class LoadingBookCourseState extends HomeFeedScreenStates {}

class SuccessBookCourseState extends HomeFeedScreenStates {}

class ErrorBookCourseState extends HomeFeedScreenStates {
  String? error;
  ErrorBookCourseState({this.error});
}
