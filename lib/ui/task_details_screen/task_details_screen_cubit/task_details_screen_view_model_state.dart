part of 'task_details_screen_view_model_cubit.dart';

@immutable
sealed class TaskDetailsScreenViewModelState {}

final class TaskDetailsScreenViewModelInitial extends TaskDetailsScreenViewModelState {}
final class TaskDetailsScreenViewModelLoading extends TaskDetailsScreenViewModelState {}
final class TaskDetailsScreenViewModelSuccessfull extends TaskDetailsScreenViewModelState {}
final class TaskDetailsScreenViewModelError extends TaskDetailsScreenViewModelState{
  final String errorMessage;
  TaskDetailsScreenViewModelError(this.errorMessage);
}
