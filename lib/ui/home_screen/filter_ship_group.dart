import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/ui/home_screen/home_screen_cubit/home_screen_view_model_cubit.dart';
import 'package:tasks_app/ui/home_screen/home_screen_cubit/home_screen_view_model_cubit.dart';

import '../../utiles/app_colors.dart';
import '../../utiles/app_fonts.dart';

class FilterShipGroup extends StatefulWidget {
  final List<String> options;
  int selectedIndex;

  FilterShipGroup({
    required this.options,
    required this.selectedIndex,
    super.key,
  });

  @override
  State<FilterShipGroup> createState() => _FilterShipGroupState();
}

class _FilterShipGroupState extends State<FilterShipGroup> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeScreenViewModelCubit, HomeScreenViewModelState>(
      builder: (context, state) {
        return Container(
          width: width,
          height: height * 0.08,
          padding: EdgeInsets.symmetric(vertical: height * 0.018),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.selectedIndex = index;
                  setState(() {});
                  if(widget.options[1] == "Todo"){
                    context.read<HomeScreenViewModelCubit>().filterTasks(
                      widget.selectedIndex,
                      context.read<HomeScreenViewModelCubit>().selectedPriority,
                    );
                  }else{
                    context.read<HomeScreenViewModelCubit>().filterTasks(
                      context.read<HomeScreenViewModelCubit>().selectedStatus,
                      widget.selectedIndex,
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  decoration: BoxDecoration(
                    color: widget.selectedIndex == index
                        ? AppColors.primaryColor
                        : AppColors.lighterGreyColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    widget.options[index],
                    style: widget.selectedIndex == index
                        ? AppFonts.bold16White
                        : AppFonts.regular14Grey,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: width * 0.04);
            },
            itemCount: widget.options.length,
          ),
        );
      },
    );
  }
}
