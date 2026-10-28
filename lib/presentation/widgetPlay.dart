import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/customDropDown.dart';
import 'package:local_mart/const/widgets/customListTie.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/const/widgets/custom_button.dart';

class Widgetplay extends StatefulWidget {
  const Widgetplay({super.key});

  @override
  State<Widgetplay> createState() => _WidgetplayState();
}

class _WidgetplayState extends State<Widgetplay> {
  String? selectedCity;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: Icon(Icons.arrow_back),
        backgroundColor: Appcolors.darkBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Customdropdown(
              items: ["Pune", "Mumbai", "Nagar"],
              hint: "Select City",
              value: selectedCity,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),

            SizedBox(height: 30),

            Customdropdown(
              items: ["Male", "Female", "Custom"],
              hint: "Select Gender",
              value: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),

            SizedBox(height: 30),

            CustomButton(),

            SizedBox(height: 30),

            Customlisttie(),
            Customlisttie(
              decoration: BoxDecoration(
                color: Appcolors.ratingYellow,
                borderRadius: BorderRadius.circular(18),
              ),

              leading: Icon(Icons.search),
              title: "Search",
              trailing: Icon(Icons.keyboard_arrow_left),
            ),
          ],
        ),
      ),
    );
  }
}
