import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_response.dart';
import 'package:tasks_app/services/shared_pref_services.dart';
import 'package:tasks_app/ui/custom_widgets/custom_text_form_field.dart';
import 'package:tasks_app/ui/home_screen/filter_ship_group.dart';
import 'package:tasks_app/ui/home_screen/task_card.dart';
import 'package:tasks_app/utiles/app_fonts.dart';
import 'package:tasks_app/utiles/app_images.dart';

import '../../utiles/app_colors.dart';

class HomeScreenView extends StatelessWidget {
  final SharedPrefServices sharedPrefServices;
  int selectedIndexStatus = 0;
  int selectedIndexPriority = 0;
  final List<TaskResponse> dummyTasks = [
    TaskResponse.fromJson({
      "id": 1,
      "title": "Fix login bug",
      "description": "Resolve the authentication issue on the login screen",
      "status": "In Progress",
      "priority": "High",
      "dueDate": "2026-04-10",
      "assignedTo": 2
    }),
    TaskResponse.fromJson({
      "id": 2,
      "title": "Design dashboard UI",
      "description": "Create the main dashboard wireframes and send for review",
      "status": "Todo",
      "priority": "Medium",
      "dueDate": "2026-04-12",
      "assignedTo": 2
    }),
    TaskResponse.fromJson({
      "id": 3,
      "title": "Write unit tests",
      "description": "Write unit tests for the API manager and cubits",
      "status": "Done",
      "priority": "Low",
      "dueDate": "2026-04-08",
      "assignedTo": 2
    }),
    TaskResponse.fromJson({
      "id": 4,
      "title": "Update dependencies",
      "description": "Update all outdated Flutter packages to latest versions",
      "status": "Todo",
      "priority": "High",
      "dueDate": "2026-04-15",
      "assignedTo": 2
    }),
  ];

  HomeScreenView(this.sharedPrefServices, {super.key});


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks", style: AppFonts.bold32Primary),
        actions: [
          IconButton(
            onPressed: () {
              ///todo:
              ///implement the logout functionality
              print("button pressed");
            },
            icon: Image.asset(AppImages.logoutIcon),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.042),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: height * 0.01),
              Customtextformfield(
                borderColor: AppColors.transparentColor,
                prefixIcon: AppImages.searchIcon,
                prefixIconColor: AppColors.lightGreyColor,
                labelText: "Search tasks...",
                validate: (value) {
                  return null;
                },
              ),
              Text("Status", style: AppFonts.bold14Grey),
              FilterShipGroup(options: ["All", "Todo", "In Progress", "Done"],selectedIndex: selectedIndexStatus,),
              Text("Priority", style: AppFonts.bold14Grey),
              FilterShipGroup(options: ["All", "Low", "Medium", "High"],selectedIndex: selectedIndexPriority,),
              SizedBox(
                height: height * 0.6,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskCard(taskResponse: dummyTasks[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemCount: dummyTasks.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
