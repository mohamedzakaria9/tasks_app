import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/services/shared_pref_services.dart';
import 'package:tasks_app/ui/custom_widgets/custom_elevated_button.dart';
import 'package:tasks_app/ui/custom_widgets/custom_text_form_field.dart';
import 'package:tasks_app/ui/login_screen/login_form.dart';
import 'package:tasks_app/ui/login_screen/login_screen_cubit/login_screen_view_model_cubit.dart';
import 'package:tasks_app/utiles/app_fonts.dart';
import 'package:tasks_app/utiles/app_images.dart';
import 'package:tasks_app/utiles/app_routes.dart';

import '../../utiles/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final SharedPrefServices sharedPrefServices;

  LoginScreen(this.sharedPrefServices, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenViewModelCubit(widget.sharedPrefServices),
      child: BlocConsumer<LoginScreenViewModelCubit, LoginScreenViewModelState>(
        builder: (context, state) {
          if (state is LoginScreenViewModelLoading ||
              state is LoginScreenViewModelSuccessfull) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is LoginScreenViewModelError ||
              state is LoginScreenViewModelInitial ||
              state is LoginScreenViewModelShowHidePassword) {
            return Scaffold(
              body: SingleChildScrollView(child: LoginForm(email: email, password: password)),
            );
          } else {
            return SizedBox.shrink();
          }
        },
        listener: (context, state) async {
          if (state is LoginScreenViewModelSuccessfull) {
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          } else if (state is LoginScreenViewModelError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
      ),
    );
  }
}
