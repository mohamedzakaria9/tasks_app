import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/models/task_response.dart';

import '../../../apis/api_manager.dart';

part 'add_task_screen_view_model_state.dart';

class AddTaskScreenViewModelCubit extends Cubit<AddTaskScreenViewModelState> {
  AddTaskScreenViewModelCubit() : super(AddTaskScreenViewModelInitial());

  String selectedStatus = "Todo";
  String selectedPriority = "Low";

  void addTask(String token,TaskResponse task) async{
    try{
      emit(AddTaskScreenViewModelLoading());
      var response = await ApiManager.addTask(token, task);
      if(response?.statusCode == 201){
        emit(AddTaskScreenViewModelSuccess());
      }else{
        emit(AddTaskScreenViewModelError("Something went wrong"));
      }
    }catch(e){
      emit(AddTaskScreenViewModelError("Something went wrong"));
    }
  }

  void updateTask(String token, int taskId, TaskResponse task) async {
    emit(AddTaskScreenViewModelLoading());
    try {
      var response = await ApiManager.updateTask(token, taskId, task);
      if (response?.statusCode == 200) {
        emit(AddTaskScreenViewModelSuccess());
      } else if (response?.statusCode == 401) {
        emit(AddTaskScreenViewModelError("Unauthorized - please login again"));
      } else if (response?.statusCode == 403) {
        emit(AddTaskScreenViewModelError("You don't have permission to update this task"));
      } else if (response?.statusCode == 404) {
        emit(AddTaskScreenViewModelError("Task not found"));
      } else {
        emit(AddTaskScreenViewModelError("Something went wrong"));
      }
    } catch (e) {
      emit(AddTaskScreenViewModelError(e.toString()));
    }
  }
}
