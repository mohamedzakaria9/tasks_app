import 'package:flutter/material.dart';
import 'package:tasks_app/ui/custom_widgets/custom_elevated_button.dart';
import 'package:tasks_app/ui/custom_widgets/custom_text_form_field.dart';
import 'package:tasks_app/utiles/app_fonts.dart';
import 'package:tasks_app/utiles/app_images.dart';

import '../../utiles/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
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
                    validate: (value) {
                      return null;
                    },
                    prefixIconColor: AppColors.lightGreyColor,
                    fillColor: AppColors.primaryLightColor,
                  ),
                  SizedBox(height: height * 0.03),
                  Customtextformfield(
                    prefixIcon: AppImages.lockIconImage,
                    isSuffixIcon: true,
                    suffixIcon: AppImages.eyeIconImage,
                    suffixIconOnPress: () {},
                    password: true,
                    labelText: "Password",
                    validate: (value) {
                      return null;
                    },
                    prefixIconColor: AppColors.lightGreyColor,
                    fillColor: AppColors.primaryLightColor,
                  ),
                  SizedBox(height: height * 0.03),
                  CustomElevatedButton(
                    content: Text("Login", style: AppFonts.bold16White),
                    onPress: () {},

                  ),
                  SizedBox(height: height*0.03,),
                  Text("Forgot Password?",style: AppFonts.bold14Grey,textAlign: TextAlign.center,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
