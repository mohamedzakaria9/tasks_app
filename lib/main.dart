import 'package:flutter/material.dart';
import 'package:tasks_app/ui/login_screen/login_screen_view.dart';
import 'package:tasks_app/utiles/app_colors.dart';
import 'package:tasks_app/utiles/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryLightColor
      ),
      initialRoute: AppRoutes.loginScreen,
      routes: {
        AppRoutes.loginScreen : (context) => LoginScreen(),
      },
    );
  }
}