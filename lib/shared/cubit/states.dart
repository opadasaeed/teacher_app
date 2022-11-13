abstract class SharedStates {}

class InitialSharedState extends SharedStates {}

class LoadingSharedState extends SharedStates {}

class ReloadingSharedState extends SharedStates {}

class SuccessSharedState extends SharedStates {}

class SuccessUserSharedState extends SharedStates {}

class ErrorSharedState extends SharedStates {
  final String error;

  ErrorSharedState(this.error);
}