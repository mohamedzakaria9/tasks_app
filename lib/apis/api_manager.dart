import 'dart:convert';

import 'package:tasks_app/apis/api_constants.dart';
import 'package:tasks_app/apis/api_endPoints.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_app/models/login_responce.dart';

class ApiManager {
  static Future<http.Response?> login(String email, String password) async{
    try{
      Uri url = Uri.parse(ApiConstants.baseUrl+ApiEndpoints.login);
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      return response;
    }catch (e){
      print(e);
      return null;
    }
  }
  // static Future<http.Response?> getTasks(){
  //   Uri url = Uri.parse(ApiConstants.baseUrl+ApiEndpoints.tasks)
  // }
}
