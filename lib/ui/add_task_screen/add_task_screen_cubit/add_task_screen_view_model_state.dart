part of 'add_task_screen_view_model_cubit.dart';

@immutable
sealed class AddTaskScreenViewModelState {}

final class AddTaskScreenViewModelInitial extends AddTaskScreenViewModelState {}
final class AddTaskScreenViewModelLoading extends AddTaskScreenViewModelState{}
final class AddTaskScreenViewModelSuccess extends AddTaskScreenViewModelState{}
final class AddTaskScreenViewModelError extends AddTaskScreenViewModelState{
  final String errorMessage;
  AddTaskScreenViewModelError(this.errorMessage);
}
