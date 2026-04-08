import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_response.dart';
import 'package:tasks_app/ui/home_screen/status_badge.dart';

import '../../utiles/app_colors.dart';
import '../../utiles/app_fonts.dart';
import '../../utiles/app_images.dart';

class TaskCard extends StatelessWidget {
  final TaskResponse taskResponse;

  const TaskCard({required this.taskResponse, super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(
                status: taskResponse.status!,
                statusColor: taskResponse.status == "Todo"
                    ? AppColors.blueBadgeBg
                    : taskResponse.status == "In Progress"
                    ? AppColors.orangeBadgeBg
                    : AppColors.greenBadgeBg,
                textColor: taskResponse.status == "Todo"
                    ? AppColors.blueText
                    : taskResponse.status == "In Progress"
                    ? AppColors.orangeText
                    : AppColors.greenText,
              ),
              StatusBadge(
                status: taskResponse.priority!,
                statusColor: taskResponse.priority == "Low"
                    ? AppColors.greyBadgeBg
                    : taskResponse.priority == "Medium"
                    ? AppColors.yellowBadgeBg
                    : AppColors.redBadgeBg,
                textColor: taskResponse.priority == "Low"
                    ? AppColors.greyText
                    : taskResponse.priority == "Medium"
                    ? AppColors.yellowText
                    : AppColors.redText,
              ),
            ],
          ),
          Text(taskResponse.title!, style: AppFonts.bold18Black),
          Text(
            taskResponse.description!,
            style: AppFonts.regular14Grey,
          ),
          SizedBox(height: height * 0.03),
          Divider(height: 10),
          Container(
            child: Row(
              children: [
                ImageIcon(AssetImage(AppImages.dateIcon), size: 50),
                Text("Due: ${taskResponse.dueDate}"),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
