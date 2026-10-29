import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';

class CustomBottomnavigationbar extends StatefulWidget {
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? height;
  final double? iconSize;
  final double? fontsize;
  final BorderRadius? borderRadius;
  final List<BottomNavigationBarItem>? items;
  final int currentIndex;

  const CustomBottomnavigationbar({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.height,
    this.iconSize,
    this.fontsize,
    this.borderRadius,
    this.items,
    this.currentIndex = 0,
  });

  @override
  State<CustomBottomnavigationbar> createState() =>
      _CustomBottomnavigationbarState();
}

class _CustomBottomnavigationbarState extends State<CustomBottomnavigationbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.height ?? 65,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Appcolors.appBackground,
          borderRadius:
              widget.borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          onTap: (index) {
            if (widget.onTap != null) widget.onTap!(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: widget.selectedColor ?? Appcolors.darkBlue,
          unselectedItemColor:
              widget.unselectedColor ?? Appcolors.secondaryText,
          items:
              widget.items ??
              const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_outlined),
                  label: "Shops",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  label: "Wishlist",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
        ),
      ),
    );
  }
}
