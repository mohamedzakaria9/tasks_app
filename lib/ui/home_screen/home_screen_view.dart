import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/apis/api_manager.dart';
import 'package:tasks_app/models/task_response.dart';
import 'package:tasks_app/services/shared_pref_services.dart';
import 'package:tasks_app/ui/custom_widgets/custom_text_form_field.dart';
import 'package:tasks_app/ui/home_screen/filter_ship_group.dart';
import 'package:tasks_app/ui/home_screen/home_screen_cubit/home_screen_view_model_cubit.dart';
import 'package:tasks_app/ui/home_screen/task_card.dart';
import 'package:tasks_app/ui/login_screen/login_screen_cubit/login_screen_view_model_cubit.dart';
import 'package:tasks_app/utiles/app_fonts.dart';
import 'package:tasks_app/utiles/app_images.dart';
import 'package:tasks_app/utiles/app_routes.dart';

import '../../utiles/app_colors.dart';

class HomeScreenView extends StatefulWidget {
  final SharedPrefServices sharedPrefServices;

  HomeScreenView(this.sharedPrefServices, {super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int selectedIndexStatus = 0;

  int selectedIndexPriority = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => HomeScreenViewModelCubit(
        sharedPrefServices: widget.sharedPrefServices,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Tasks", style: AppFonts.bold32Primary),
          actions: [
            IconButton(
              onPressed: () {
                ///todo:
                ///implement the logout functionality
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
                Builder(
                  builder: (context) {
                    return Customtextformfield(
                      borderColor: AppColors.transparentColor,
                      prefixIcon: AppImages.searchIcon,
                      prefixIconColor: AppColors.lightGreyColor,
                      labelText: "Search tasks...",
                      validate: (value) {
                        return null;
                      },
                      onChange: (value) {
                        context.read<HomeScreenViewModelCubit>().searchTasks(
                          value!,
                        );
                      },
                    );
                  },
                ),
                Text("Status", style: AppFonts.bold14Grey),
                FilterShipGroup(
                  options: ["All", "Todo", "In Progress", "Done"],
                  selectedIndex: selectedIndexStatus,
                ),
                Text("Priority", style: AppFonts.bold14Grey),
                FilterShipGroup(
                  options: ["All", "Low", "Medium", "High"],
                  selectedIndex: selectedIndexPriority,
                ),
                BlocConsumer<
                  HomeScreenViewModelCubit,
                  HomeScreenViewModelState
                >(
                  builder: (context, state) {
                    if (state is HomeScreenViewModelSuccess) {
                      return SizedBox(
                        height: height * 0.6,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return TaskCard(
                              taskResponse: state.tasksList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: height * 0.02);
                          },
                          itemCount: state.tasksList.length,
                        ),
                      );
                    } else if (state is HomeScreenViewModelError) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                  listener: (context, state) {
                    if (state is HomeScreenViewModelError) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.loginScreen,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addTaskScreen);
          },
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
