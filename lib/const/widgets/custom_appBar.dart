import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Color? backgroundColor;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final double? titleSpacing;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;

  const CustomAppbar({
    super.key,
    this.title,
    this.titleWidget,
    this.backgroundColor,
    this.showBackButton = true,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.titleSpacing,
    this.textStyle,
    this.borderRadius,
    this.toolbarHeight,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    (toolbarHeight ?? 90) + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight ?? 90,
      automaticallyImplyLeading: showBackButton,
      leadingWidth: leadingWidth ?? 60,
      titleSpacing: titleSpacing ?? 0,
      backgroundColor: backgroundColor ?? Appcolors.lightBlue,
      foregroundColor: Appcolors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ??
            BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
      ),

      title:
          titleWidget ??
          Text(title ?? "Select Your Location", style: textStyle),

      actions: actions,
      leading: leading == null
          ? null
          : Transform.translate(offset: Offset(0, 0), child: leading),
      bottom: bottom,
    );
  }
}
