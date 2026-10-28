import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/customListTie.dart';
import 'package:local_mart/const/widgets/custom_BottomNavigationBar.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/const/widgets/custom_button.dart';
import 'package:local_mart/const/widgets/custom_textFormField.dart';
import 'package:local_mart/presentation/CategoriesScreen.dart';
import 'package:local_mart/presentation/homeScreen.dart';
import 'package:local_mart/presentation/shops_screen.dart';
import 'package:local_mart/presentation/wishlist_screen.dart';
import 'package:local_mart/repo/userProfileEdit_repo.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  // final _userprofileeditRepo = UserprofileeditRepo();

  String userName = "Ganesh Gund";
  String userPhone = "+91 98765 43210";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.appBackground,
      appBar: CustomAppbar(
        showBackButton: false,
        backgroundColor: Appcolors.darkBlue,
        toolbarHeight: 90,
        titleWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My  Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildUserCard(),
              SizedBox(height: 10),
              _buildListTie(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomnavigationbar(
        currentIndex: 4,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Categoriesscreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ShopsScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WishlistScreen()),
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Profilescreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Appcolors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Appcolors.appBackground,
                radius: 35,
                child: Icon(Icons.person, color: Appcolors.darkBlue),
              ),

              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      userPhone,
                      style: TextStyle(
                        fontSize: 15,
                        color: Appcolors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _buildDailogEdit,
                icon: Icon(
                  Icons.edit_outlined,
                  color: Appcolors.darkBlue,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildDailogEdit() {
    final TextEditingController nameController = TextEditingController(
      text: userName,
    );
    final TextEditingController phoneController = TextEditingController(
      text: userPhone,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Appcolors.appBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          title: Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextformfield(
                controller: nameController,
                hintText: "Full Name",
                prefixIcon: Icon(Icons.person_outline),
              ),

              SizedBox(height: 12),

              CustomTextformfield(
                controller: phoneController,
                hintText: "Phone Number",
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  userName = "Guest User";
                  userPhone = "+91 9272553732";
                });

                Navigator.pop(context);
              },
              child: Text("Profile Remove"),
            ),

            CustomButton(
              text: "Save",
              width: 90,
              height: 38,
              fontSize: 14,
              borderRadius: 8,
              backgroundColor: Appcolors.darkBlue,
              onTap: () async {
                await UserprofileeditRepo().updateProfile(
                  name: nameController.text,
                  phone: phoneController.text,
                );

                setState(() {
                  userName = nameController.text;
                  userPhone = phoneController.text;
                });

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildListTie() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        spacing: 5,
        children: [
          Customlisttie(
            leading: Icon(
              Icons.location_on_outlined,
              color: Appcolors.darkBlue,
            ),
            title: "My Location",
          ),

          Customlisttie(
            leading: Icon(
              Icons.inventory_2_outlined,
              color: Appcolors.darkBlue,
            ),
            title: "My Orders",
          ),

          Customlisttie(
            leading: Icon(Icons.favorite_border, color: Appcolors.darkBlue),
            title: "My Wishlist",
          ),

          Customlisttie(
            leading: Icon(
              Icons.help_outline_rounded,
              color: Appcolors.darkBlue,
            ),
            title: "Help & Outlined",
          ),

          Customlisttie(
            leading: Icon(Icons.settings_outlined, color: Appcolors.darkBlue),
            title: "Settings",
          ),
        ],
      ),
    );
  }
}
