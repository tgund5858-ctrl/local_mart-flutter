import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/custom_BottomNavigationBar.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/const/widgets/custom_textFormField.dart';
import 'package:local_mart/presentation/CategoriesScreen.dart';
import 'package:local_mart/presentation/ProfileScreen.dart';
import 'package:local_mart/presentation/cart_screen.dart';
import 'package:local_mart/presentation/shops_screen.dart';
import 'package:local_mart/presentation/wishlist_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:local_mart/model/category_model.dart';
import 'package:local_mart/repo/category_repo.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String userLocation = "loading..";

  final CategoryRepo _categoryRepo = CategoryRepo();
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _loadsavedLocation();
    _categoriesFuture = _categoryRepo.fetchCategories();
  }

  Future<void> _loadsavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    final String city = prefs.getString('user_city') ?? "Pune";
    final String location = prefs.getString('user_location') ?? "Hinjewadi";

    setState(() {
      userLocation = "$location,$city";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.appBackground,
      appBar: CustomAppbar(
        backgroundColor: Appcolors.darkBlue,
        toolbarHeight: 130,
        showBackButton: false,
        titleWidget: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Local',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Mart',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined, size: 26),
                  ),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.location_on, size: 14),
                  SizedBox(width: 4),
                  Text(userLocation, style: TextStyle(fontSize: 13)),
                ],
              ),

              SizedBox(height: 5),

              CustomTextformfield(
                prefixIcon: Icon(Icons.search, color: Appcolors.secondaryText),
                hintText: "Search Your Product..!",
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildBanner(),
                SizedBox(height: 20),
                _buildCategory(),
                SizedBox(height: 20),
                _buildPopularProducts(),
                SizedBox(height: 20),
                _buildOfferOneBanner(),
                SizedBox(height: 20),
                _buildOfferTwoBanner(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomnavigationbar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          } else if (index == 1) {
            Navigator.push(
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

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/banner.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildOfferOneBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage("assets/images/offerOne.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildOfferTwoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage("assets/images/offerTwo.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return SizedBox(
      height: 90,
      child: FutureBuilder<List<CategoryModel>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error : ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Category Not Found"));
          }

          final categories = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Appcolors.appBackground,
                      ),
                      child: ClipOval(
                        child: Image.network(cat.imageUrl, fit: BoxFit.cover),
                      ),
                    ),

                    SizedBox(height: 6),

                    SizedBox(
                      width: 70,
                      child: Text(
                        cat.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPopularProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Products Offer",
            style: TextStyle(
              fontSize: 16,
              color: Appcolors.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "View All",
            style: TextStyle(
              color: Appcolors.darkBlue,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
