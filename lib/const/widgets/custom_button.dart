import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Appcolors.darkBlue,
          foregroundColor: textColor ?? Appcolors.appBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 22),
          ),
        ),
        child: Text(
          text ?? "Get Start",
          style: TextStyle(
            fontSize: fontSize ?? 18,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
