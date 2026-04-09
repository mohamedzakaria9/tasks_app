import 'package:flutter/material.dart';
import 'package:tasks_app/ui/home_screen/status_badge.dart';
import 'package:tasks_app/utiles/app_fonts.dart';
import 'package:tasks_app/utiles/app_images.dart';

import '../../models/task_response.dart';
import '../../utiles/app_colors.dart';

class TaskDetailsScreenView extends StatelessWidget {
  const TaskDetailsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as TaskResponse;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
            SizedBox(height: height*0.1,),
            InkWell(
              onTap: (){

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
          ],
        ),
      ),
    );
  }
}
