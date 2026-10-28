import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';

class Customdropdown extends StatelessWidget {
  final List<String> items;
  final String? hint;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Border? borderColor;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Icon? icon;
  final TextStyle? textStyle;

  const Customdropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.height,
    this.width,
    this.padding,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
    this.icon,
    this.hint,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? double.infinity,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor ?? Appcolors.white,
        border: borderColor ?? Border.all(color: Appcolors.secondaryText),
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: SizedBox(),
        hint: Text(hint ?? "Select Value", style: textStyle),
        icon: icon ?? Icon(Icons.keyboard_arrow_down),
        items: items.map((items) {
          return DropdownMenuItem<String>(value: items, child: Text(items));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
