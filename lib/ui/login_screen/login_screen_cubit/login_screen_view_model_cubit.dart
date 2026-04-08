import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasks_app/apis/api_manager.dart';
import 'package:tasks_app/models/login_responce.dart';
import 'package:tasks_app/services/shared_pref_services.dart';

part 'login_screen_view_model_state.dart';

class LoginScreenViewModelCubit extends Cubit<LoginScreenViewModelState> {
  final SharedPrefServices sharedPrefServices;
  bool showPassword = true;

  LoginScreenViewModelCubit(this.sharedPrefServices)
    : super(LoginScreenViewModelInitial());

  void showHidePassword() {
    showPassword = !showPassword;
    emit(LoginScreenViewModelShowHidePassword(showPassword));
  }

  void login(String email, String password) async {
    try {
      emit(LoginScreenViewModelLoading());
      var response = await ApiManager.login(email, password);
      if (response?.statusCode == 200) {
        var loginResponse = LoginResponce.fromJson(jsonDecode(response!.body));
        if (loginResponse.accessToken != null &&
            loginResponse.user != null &&
            loginResponse.user!.id != null &&
            loginResponse.user!.name != null &&
            loginResponse.user!.email != null){
          await sharedPrefServices.saveUser(
            token: loginResponse.accessToken!,
            name: loginResponse.user!.name!,
            email: loginResponse.user!.email!,
            id: loginResponse.user!.id!,
          );
          await Future.delayed(const Duration(seconds: 2));
          emit(LoginScreenViewModelSuccessfull(loginResponse));
        }else{
          emit(LoginScreenViewModelError("Something Went Wrong"));
        }
      } else if (response!.statusCode == 400 || response.statusCode == 401) {
        emit(LoginScreenViewModelError("Invalid email or password"));
      } else if (response.statusCode == 404) {
        emit(LoginScreenViewModelError("Server Error Occurred"));
      } else {
        emit(LoginScreenViewModelError("Something Went Wrong"));
      }
    } catch (e) {
      emit(LoginScreenViewModelError(e.toString()));
    }
  }
}
