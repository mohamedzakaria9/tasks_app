import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/apis/api_manager.dart';
import 'package:tasks_app/services/shared_pref_services.dart';
import 'package:tasks_app/ui/home_screen/status_badge.dart';
import 'package:tasks_app/ui/task_details_screen/task_details_screen_cubit/task_details_screen_view_model_cubit.dart';
import 'package:tasks_app/utiles/app_fonts.dart';
import 'package:tasks_app/utiles/app_images.dart';
import 'package:tasks_app/utiles/app_routes.dart';

import '../../models/task_response.dart';
import '../../utiles/app_colors.dart';

class TaskDetailsScreenView extends StatelessWidget {
  final SharedPrefServices sharedPrefServices;

  const TaskDetailsScreenView(this.sharedPrefServices, {super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as TaskResponse;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => TaskDetailsScreenViewModelCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Task Details", style: AppFonts.bold32Primary),
          actions: [
            IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage(AppImages.editIcon)),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(task.title ?? "", style: AppFonts.regular36black),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: .start,
                children: [
                  StatusBadge(
                    status: task.status!,
                    statusColor: task.status == "Todo"
                        ? AppColors.blueBadgeBg
                        : task.status == "In Progress"
                        ? AppColors.orangeBadgeBg
                        : AppColors.greenBadgeBg,
                    textColor: task.status == "Todo"
                        ? AppColors.blueText
                        : task.status == "In Progress"
                        ? AppColors.orangeText
                        : AppColors.greenText,
                  ),
                  SizedBox(width: width * 0.03),
                  StatusBadge(
                    status: task.priority!,
                    statusColor: task.priority == "Low"
                        ? AppColors.greyBadgeBg
                        : task.priority == "Medium"
                        ? AppColors.yellowBadgeBg
                        : AppColors.redBadgeBg,
                    textColor: task.priority == "Low"
                        ? AppColors.greyText
                        : task.priority == "Medium"
                        ? AppColors.yellowText
                        : AppColors.redText,
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.03,
                  horizontal: width * 0.03,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Description", style: AppFonts.bold14Grey),
                    SizedBox(height: height * 0.01),
                    Text(task.description!),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.03,
                  horizontal: width * 0.03,
                ),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ImageIcon(AssetImage(AppImages.dateIcon)),
                    SizedBox(width: width * 0.02),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text("Due Date", style: AppFonts.bold14Grey),
                        Text(task.dueDate!, style: AppFonts.bold18Black),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),
              Builder(
                builder: (context) {
                  return BlocListener<
                    TaskDetailsScreenViewModelCubit,
                    TaskDetailsScreenViewModelState
                  >(
                    listener: (context, state) {
                      if (state is TaskDetailsScreenViewModelSuccessfull) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Task deleted successfully")),
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.homeScreen);
                      } else if (state is TaskDetailsScreenViewModelError) {
                        if (state.errorMessage.contains("Unauthorized")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AppRoutes.loginScreen);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        context
                            .read<TaskDetailsScreenViewModelCubit>()
                            .deleteTask(sharedPrefServices.token!, task.id!);
                      },
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          ImageIcon(
                            AssetImage(AppImages.deleteIcon),
                            color: AppColors.lightRedColor,
                          ),
                          Text("Delete Task", style: AppFonts.bold16Red),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
