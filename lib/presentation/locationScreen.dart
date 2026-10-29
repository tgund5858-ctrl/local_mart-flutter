import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/customDropDown.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/const/widgets/custom_button.dart';
import 'package:local_mart/presentation/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Locationscreen extends StatefulWidget {
  const Locationscreen({super.key});

  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  String? selectedCity = "Pune";
  String? selectedArea = "Hadpsar";
  String? selectedDeliveryAddress = "Baner";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.appBackground,
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Appcolors.primaryBlue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                _buildHeading(),

                SizedBox(height: 20),

                _buildDropDownButton(),

                SizedBox(height: 50),

                CustomButton(
                  text: "Continue",
                  onTap: () async {
                    if (selectedCity == null ||
                        selectedArea == null ||
                        selectedDeliveryAddress == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please Select All Options!"),
                          backgroundColor: Appcolors.errorRed,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    try {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('user_city', selectedCity!);
                      await prefs.setString('user_area', selectedArea!);
                      await prefs.setString(
                        'user_location',
                        selectedDeliveryAddress!,
                      );

                      if (!context.mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homescreen(),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: $e"),
                          backgroundColor: Appcolors.errorRed,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose your city, and delivery location to get the best local detail",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Appcolors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildDropDownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "City",
          style: TextStyle(
            fontSize: 17,
            color: Appcolors.secondaryText,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 5),

        Customdropdown(
          items: ["Pune", "Waghole", "Daund", "Katraj"],
          hint: "Select City",
          value: selectedCity,
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
          },
        ),

        SizedBox(height: 20),

        Text(
          "Area",
          style: TextStyle(
            fontSize: 17,
            color: Appcolors.secondaryText,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 5),

        Customdropdown(
          items: ["Hadpsar", "Uruli", "Pcmc", "Loni"],
          hint: "Select Area",
          value: selectedArea,
          onChanged: (value) {
            setState(() {
              selectedArea = value;
            });
          },
        ),

        SizedBox(height: 20),

        Text(
          "Delivery Location",
          style: TextStyle(
            fontSize: 17,
            color: Appcolors.secondaryText,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 5),

        Customdropdown(
          items: ["Nangaon", "Kedgaon", "Baner", "Kothrud"],
          hint: "Select Delivery Location",
          value: selectedDeliveryAddress,
          onChanged: (value) {
            setState(() {
              selectedDeliveryAddress = value;
            });
          },
        ),
      ],
    );
  }
}
