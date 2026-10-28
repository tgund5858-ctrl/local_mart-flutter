import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';

class CustomTextformfield extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool readOnly;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? textColor;
  final double? fontSize;

  const CustomTextformfield({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines,
    this.readOnly = false,
    this.backgroundColor,
    this.borderRadius,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Appcolors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        maxLines: maxLines,
        readOnly: readOnly,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText ?? "Enter Your Name!",
          hintStyle: TextStyle(
            color: textColor ?? Appcolors.secondaryText,
            fontSize: fontSize ?? 15,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
