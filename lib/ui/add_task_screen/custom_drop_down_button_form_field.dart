import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utiles/app_colors.dart';

typedef OnChange = void Function(String?);

class CustomDropDownButtonFormField extends StatefulWidget {
  final List<String> options;
  String selected;
  OnChange onChange;

  CustomDropDownButtonFormField({
    required this.selected,
    required this.options,
    super.key,
    required this.onChange,
  });

  @override
  State<CustomDropDownButtonFormField> createState() =>
      _CustomDropDownButtonFormFieldState();
}

class _CustomDropDownButtonFormFieldState
    extends State<CustomDropDownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text("Current State"),
          SizedBox(height: height * 0.01),
          DropdownButtonFormField<String>(
            initialValue: widget.selected,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF0F0F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: widget.options.map((status) {
              return DropdownMenuItem(value: status, child: Text(status));
            }).toList(),
            onChanged: widget.onChange,
          ),
        ],
      ),
    );
  }
}
