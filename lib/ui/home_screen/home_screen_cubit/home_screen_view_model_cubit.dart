import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasks_app/apis/api_manager.dart';
import 'package:tasks_app/services/shared_pref_services.dart';

import '../../../models/task_response.dart';

part 'home_screen_view_model_state.dart';

class HomeScreenViewModelCubit extends Cubit<HomeScreenViewModelState> {
  SharedPrefServices sharedPrefServices;

  int selectedStatus = 0;
  int selectedPriority = 0;

  List<TaskResponse> allTasks = [];

  HomeScreenViewModelCubit({required this.sharedPrefServices})
    : super(HomeScreenViewModelLoading()) {
    getTasks();
  }

  void filterTasks(int status, int priority){
    selectedStatus = status;
    selectedPriority = priority;
    String statusType = "";
    String priorityType = "";
    if(status == 0){
      statusType = "All";
    }else if(status == 1){
      statusType = "Todo";
    }else if(status == 2){
      statusType = "In Progress";
    }else if(status == 3){
      statusType = "Done";
    }
    if(priority == 0){
      priorityType = "All";
    }else if(priority == 1){
      priorityType = "Low";
    }else if(priority == 2){
      priorityType = "Medium";
    }else if(priority == 3){
      priorityType = "High";
    }
    List<TaskResponse> filteredTasks = [];
    for(TaskResponse task in allTasks){
      bool mathcStatus = statusType == "All" || task.status == statusType;
      bool mathcPriority = priorityType == "All" || task.priority == priorityType;
      if(mathcStatus && mathcPriority){
        filteredTasks.add(task);
      }
    }
    emit(HomeScreenViewModelSuccess(filteredTasks));
  }

  void getTasks() async {
    var response = await ApiManager.getTasks(
      sharedPrefServices.token!,
      sharedPrefServices.id!,
    );
    if (response?.statusCode == 200) {
      List<TaskResponse> tasks = (jsonDecode(response!.body) as List)
          .map((task) => TaskResponse.fromJson(task))
          .toList();
      allTasks = tasks;
      emit(HomeScreenViewModelSuccess(tasks));
    } else {
      emit(HomeScreenViewModelError("Something Went Wrong"));
    }
  }
}
