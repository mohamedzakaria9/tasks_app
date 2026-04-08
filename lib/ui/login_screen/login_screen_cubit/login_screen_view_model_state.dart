part of 'login_screen_view_model_cubit.dart';

@immutable
sealed class LoginScreenViewModelState {}

final class LoginScreenViewModelInitial extends LoginScreenViewModelState {}
final class LoginScreenViewModelLoading extends LoginScreenViewModelState {}
final class LoginScreenViewModelSuccessfull extends LoginScreenViewModelState{
  final LoginResponce response;
  LoginScreenViewModelSuccessfull(this.response);
}
final class LoginScreenViewModelError extends LoginScreenViewModelState{
  String errorMessage;
  LoginScreenViewModelError(this.errorMessage);
}
final class LoginScreenViewModelShowHidePassword extends LoginScreenViewModelState{
  final bool showPassword;
  LoginScreenViewModelShowHidePassword(this.showPassword);
}
