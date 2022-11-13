abstract class ThemeStates {
  const ThemeStates();
}

class InitialThemeState extends ThemeStates {}

class LoadingThemeState extends ThemeStates {}

class ReloadingThemeState extends ThemeStates {}

class SuccessThemeState extends ThemeStates {}

class ChangeState extends ThemeStates {}

class ErrorThemeState extends ThemeStates {
  final String error;

  ErrorThemeState(this.error);
}
