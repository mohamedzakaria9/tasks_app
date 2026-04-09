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
}
