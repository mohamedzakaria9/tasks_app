import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/models/task_response.dart';
import 'package:tasks_app/services/shared_pref_services.dart';
import 'package:tasks_app/ui/add_task_screen/add_task_screen_cubit/add_task_screen_view_model_cubit.dart';
import 'package:tasks_app/ui/add_task_screen/custom_drop_down_button_form_field.dart';
import 'package:tasks_app/ui/custom_widgets/custom_elevated_button.dart';
import 'package:tasks_app/ui/custom_widgets/custom_text_form_field.dart';
import 'package:tasks_app/utiles/app_images.dart';

import '../../utiles/app_colors.dart';
import '../../utiles/app_fonts.dart';
import '../../utiles/app_routes.dart';

class AddTaskScreenView extends StatefulWidget {
  final SharedPrefServices sharedPrefServices;

  AddTaskScreenView(this.sharedPrefServices, {super.key});

  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  State<AddTaskScreenView> createState() => _AddTaskScreenViewState();
}

class _AddTaskScreenViewState extends State<AddTaskScreenView> {
  final formKey = GlobalKey<FormState>();
  bool isEdit = false;
  TaskResponse? task;

  @override
  Widget build(BuildContext context) {
    // we will check if task is sent then we are in the edit
    task = ModalRoute.of(context)!.settings.arguments as TaskResponse?;
    bool isEdit = task != null;

    if (isEdit) {
      widget.dateController.text = task!.dueDate!;
      widget.titleController.text = task!.title!;
      widget.descriptionController.text = task!.description!;
    }
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) {
        var cubit = AddTaskScreenViewModelCubit();
        if (isEdit) {
          print("print from the edit");
          print(task!.status!);
          print(task!.priority!);
          print("print cubit variables");
          print(cubit.selectedStatus);
          print(cubit.selectedPriority);
          cubit.selectedStatus = task!.status!;
          cubit.selectedPriority = task!.priority!;
          print("this is after the cubit variables reset");
          print(cubit.selectedStatus);
          print(cubit.selectedPriority);
        }
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  isEdit ? "Edit Task" : "New Task",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("Create Focus", style: AppFonts.bold14Grey),
                      Text(
                        "Create a new entry in your flow.",
                        style: AppFonts.regular36black,
                      ),
                      SizedBox(height: height * 0.01),
                      Customtextformfield(
                        prefixIcon: AppImages.writingIcon,
                        prefixIconColor: AppColors.lightGreyColor,
                        textEditingController: widget.titleController,
                        labelText: "Title",
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Title required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Customtextformfield(
                        prefixIcon: AppImages.writingIcon,
                        prefixIconColor: AppColors.lightGreyColor,
                        textEditingController: widget.descriptionController,
                        labelText: "Description",
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description required";
                          }
                          return null;
                        },
                        maxLines: 3,
                      ),
                      SizedBox(height: height * 0.01),
                      CustomDropDownButtonFormField(
                        options: ["Todo", "In Progress", "Done"],
                        selected: context
                            .read<AddTaskScreenViewModelCubit>()
                            .selectedStatus,
                        onChange: (value) {
                          context
                                  .read<AddTaskScreenViewModelCubit>()
                                  .selectedStatus =
                              value!;
                        },
                      ),
                      SizedBox(height: height * 0.01),
                      CustomDropDownButtonFormField(
                        options: ["Low", "Medium", "High"],
                        selected: context
                            .read<AddTaskScreenViewModelCubit>()
                            .selectedPriority,
                        onChange: (value) {
                          context
                                  .read<AddTaskScreenViewModelCubit>()
                                  .selectedPriority =
                              value!;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Customtextformfield(
                        textEditingController: widget.dateController,
                        prefixIcon: AppImages.dateIcon,
                        prefixIconColor: AppColors.lightGreyColor,
                        labelText: "Date",
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Date required";
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            widget.dateController.text = picked
                                .toString()
                                .split(" ")[0]; // formats to YYYY-MM-DD
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      BlocListener<
                        AddTaskScreenViewModelCubit,
                        AddTaskScreenViewModelState
                      >(
                        listener: (context, state) {
                          if (state is AddTaskScreenViewModelSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isEdit
                                      ? "Task updated successfully"
                                      : "Task added successfully",
                                ),
                              ),
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.homeScreen);
                          } else if (state is AddTaskScreenViewModelError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
                        },
                        child: CustomElevatedButton(
                          content: Row(
                            mainAxisAlignment: .center,
                            children: [
                              ImageIcon(
                                AssetImage(AppImages.doneIcon),
                                color: AppColors.whiteColor,
                              ),
                              SizedBox(width: width * 0.02),
                              Text(
                                isEdit ? "Update Task" : "Save Task",
                                style: AppFonts.bold16White,
                              ),
                            ],
                          ),
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              if (isEdit) {
                                context
                                    .read<AddTaskScreenViewModelCubit>()
                                    .updateTask(
                                      widget.sharedPrefServices.token!,
                                      task!.id!,
                                      TaskResponse(
                                        title: widget.titleController.text,
                                        description:
                                            widget.descriptionController.text,
                                        status: context
                                            .read<AddTaskScreenViewModelCubit>()
                                            .selectedStatus,
                                        priority: context
                                            .read<AddTaskScreenViewModelCubit>()
                                            .selectedPriority,
                                        dueDate: widget.dateController.text,
                                        assignedTo:
                                            widget.sharedPrefServices.id,
                                      ),
                                    );
                              } else {
                                context
                                    .read<AddTaskScreenViewModelCubit>()
                                    .addTask(
                                      widget.sharedPrefServices.token!,
                                      TaskResponse(
                                        title: widget.titleController.text,
                                        description:
                                            widget.descriptionController.text,
                                        status: context
                                            .read<AddTaskScreenViewModelCubit>()
                                            .selectedStatus,
                                        priority: context
                                            .read<AddTaskScreenViewModelCubit>()
                                            .selectedPriority,
                                        dueDate: widget.dateController.text,
                                        assignedTo:
                                            widget.sharedPrefServices.id,
                                      ),
                                    );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
