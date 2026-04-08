import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utiles/app_colors.dart';
import '../../utiles/app_fonts.dart';
import '../../utiles/app_images.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_text_form_field.dart';
import 'login_screen_cubit/login_screen_view_model_cubit.dart';

class LoginForm extends StatefulWidget {
  TextEditingController email;
  TextEditingController password;

  LoginForm({required this.email, required this.password, super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.15),
              Image.asset(AppImages.logoImage),
              Text("TaskFlow", style: AppFonts.extraBold36Primary),
              Text("Elevate your daily focus", style: AppFonts.regular14Grey),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.04,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.03,
                  horizontal: width * 0.06,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Customtextformfield(
                      prefixIcon: AppImages.emailIconImage,
                      labelText: "Email",
                      textEditingController: widget.email,
                      validate: (value) {
                        if (value == null || value.isEmpty) return "Email required";
                        if (!value.contains("@")) return "Enter a valid email";
                        return null;
                      },
                      prefixIconColor: AppColors.lightGreyColor,
                      fillColor: AppColors.primaryLightColor,
                    ),
                    SizedBox(height: height * 0.03),
                    Customtextformfield(
                      textEditingController: widget.password,
                      prefixIcon: AppImages.lockIconImage,
                      isSuffixIcon: true,
                      suffixIcon: AppImages.eyeIconImage,
                      suffixIconOnPress: () {
                        context
                            .read<LoginScreenViewModelCubit>()
                            .showHidePassword();
                      },
                      password: context
                          .read<LoginScreenViewModelCubit>()
                          .showPassword,
                      labelText: "Password",
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      prefixIconColor: AppColors.lightGreyColor,
                      fillColor: AppColors.primaryLightColor,
                    ),
                    SizedBox(height: height * 0.03),
                    CustomElevatedButton(
                      content: Text("Login", style: AppFonts.bold16White),
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginScreenViewModelCubit>().login(
                            widget.email.text,
                            widget.password.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      "Forgot Password?",
                      style: AppFonts.bold14Grey,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
