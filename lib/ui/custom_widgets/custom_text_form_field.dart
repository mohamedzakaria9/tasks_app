//this is the validation fucntion
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utiles/app_colors.dart';
import '../../utiles/app_fonts.dart';

typedef validation = String? Function(String?);
typedef OnChange = void Function(String?);
typedef GestureTapCallback = void Function();

class Customtextformfield extends StatelessWidget {
  Color borderColor;
  String prefixIcon;
  Color prefixIconColor;
  String labelText;
  TextStyle labelTextStyle;
  String? suffixIcon;
  bool isSuffixIcon;
  bool password;
  validation validate;
  TextEditingController? textEditingController;
  int? maxLines;
  GestureTapCallback? suffixIconOnPress;
  Color? fillColor;
  OnChange? onChange;
  bool readOnly;
  GestureTapCallback ? onTap;
  Customtextformfield({
    this.borderColor = AppColors.lightGreyColor,
    required this.prefixIcon,
    this.prefixIconColor = AppColors.primaryColor,
    required this.labelText,
    this.labelTextStyle = AppFonts.regular14Grey,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.password = false,
    required this.validate,
    this.textEditingController,
    this.maxLines,
    this.suffixIconOnPress,
    this.fillColor,
    this.onChange,
    this.readOnly = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines ?? 1,
      controller: textEditingController,
      onChanged: onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightRedColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: ImageIcon(AssetImage(prefixIcon), color: prefixIconColor),
        label: Text(labelText, style: labelTextStyle),
        suffixIcon: isSuffixIcon
            ? InkWell(
                onTap: suffixIconOnPress,
                child: ImageIcon(
                  AssetImage(suffixIcon!),
                  color: prefixIconColor,
                ),
              )
            : null,
      ),
      obscureText: password,
      obscuringCharacter: "*",
      validator: validate,
    );
  }
}
