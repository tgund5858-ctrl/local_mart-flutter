import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';

class Customlisttie extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final TextStyle? textStyle;
  final Widget? trailing;
  final Border? border;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final Decoration? decoration;
  final Color? color;
  final VoidCallback? onTap;

  const Customlisttie({
    super.key,
    this.title,
    this.leading,
    this.textStyle,
    this.trailing,
    this.border,
    this.borderRadius,
    this.width,
    this.height,
    this.decoration,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration:
            decoration ??
            BoxDecoration(
              color: color ?? Appcolors.white,
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              border:
                  border ??
                  Border.all(color: const Color.fromARGB(255, 238, 238, 238)),
            ),
        child: ListTile(
          leading: leading ?? Icon(Icons.settings),
          title: Text(
            title ?? "Settings",
            style: TextStyle(
              color: Appcolors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing:
              trailing ??
              Icon(Icons.keyboard_arrow_right, color: Appcolors.secondaryText),
          onTap: onTap,
        ),
      ),
    );
  }
}
