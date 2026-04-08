part of 'home_screen_view_model_cubit.dart';

@immutable
sealed class HomeScreenViewModelState {}

final class HomeScreenViewModelLoading extends HomeScreenViewModelState{}
final class HomeScreenViewModelSuccess extends HomeScreenViewModelState{
  final List<TaskResponse> tasksList;
  HomeScreenViewModelSuccess(this.tasksList);
}
final class HomeScreenViewModelError extends HomeScreenViewModelState{
  final String errorMessage;
  HomeScreenViewModelError(this.errorMessage);
}
