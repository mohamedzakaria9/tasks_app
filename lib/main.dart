import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/services/shared_pref_services.dart';
import 'package:tasks_app/ui/home_screen/home_screen_view.dart';
import 'package:tasks_app/ui/login_screen/login_screen_view.dart';
import 'package:tasks_app/utiles/app_colors.dart';
import 'package:tasks_app/utiles/app_routes.dart';
import 'package:tasks_app/utiles/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final prefs = await SharedPreferences.getInstance();
  final sharedPrefServices = SharedPrefServices(prefs);

  runApp(MyApp(sharedPrefServices));
}

class MyApp extends StatelessWidget {
  final SharedPrefServices sharedPrefServices;

  const MyApp(this.sharedPrefServices, {super.key});

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
        AppRoutes.loginScreen : (context) => LoginScreen(sharedPrefServices),
        AppRoutes.homeScreen: (context) => HomeScreenView(sharedPrefServices)
      },
    );
  }
}