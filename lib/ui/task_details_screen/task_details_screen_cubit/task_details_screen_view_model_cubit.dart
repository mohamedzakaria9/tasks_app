import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/apis/api_manager.dart';

part 'task_details_screen_view_model_state.dart';

class TaskDetailsScreenViewModelCubit
    extends Cubit<TaskDetailsScreenViewModelState> {
  TaskDetailsScreenViewModelCubit()
    : super(TaskDetailsScreenViewModelInitial());

  void deleteTask(String token, int taskId) async {
    emit(TaskDetailsScreenViewModelLoading());
    try {
      var response = await ApiManager.deleteTask(token, taskId);
      if(response?.statusCode == 200){
        emit(TaskDetailsScreenViewModelSuccessfull());
      }else if(response?.statusCode == 401){
        emit(TaskDetailsScreenViewModelError("Unauthorized - please login again"));
      }else if(response?.statusCode == 403){
        emit(TaskDetailsScreenViewModelError("You don't have permission to delete this task"));
      }else if(response?.statusCode == 404){
        emit(TaskDetailsScreenViewModelError("Un expected Error please try again later"));
      }
    } catch (e) {
      emit(TaskDetailsScreenViewModelError(e.toString()));
    }
  }
}
