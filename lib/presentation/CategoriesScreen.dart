import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/custom_BottomNavigationBar.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/model/category_model.dart';
import 'package:local_mart/presentation/ProfileScreen.dart';
import 'package:local_mart/presentation/homeScreen.dart';
import 'package:local_mart/presentation/shops_screen.dart';
import 'package:local_mart/presentation/wishlist_screen.dart';
import 'package:local_mart/repo/category_repo.dart';

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key});

  @override
  State<Categoriesscreen> createState() => _CategoriesscreenState();
}

class _CategoriesscreenState extends State<Categoriesscreen> {
  final CategoryRepo _categoryRepo = CategoryRepo();
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _categoryRepo.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.appBackground,
      appBar: CustomAppbar(
        showBackButton: false,
        toolbarHeight: 90,
        backgroundColor: Appcolors.darkBlue,
        titleWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.search, color: Colors.white),
            ],
          ),
        ),
      ),
      body: SafeArea(child: _buildCategories()),
      bottomNavigationBar: CustomBottomnavigationbar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Homescreen()),
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

  Widget _buildCategories() {
    return FutureBuilder<List<CategoryModel>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error : ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Categories not found"));
        }

        final categories = snapshot.data!;

        return GridView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final cat = categories[index];

            return Card(
              color: Appcolors.white,
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Appcolors.appBackground,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(cat.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      cat.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
