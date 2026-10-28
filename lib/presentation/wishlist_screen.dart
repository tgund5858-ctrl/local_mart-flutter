import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/custom_BottomNavigationBar.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/const/widgets/custom_button.dart';
import 'package:local_mart/model/product_model.dart';
import 'package:local_mart/presentation/CategoriesScreen.dart';
import 'package:local_mart/presentation/ProfileScreen.dart';
import 'package:local_mart/presentation/homeScreen.dart';
import 'package:local_mart/presentation/shops_screen.dart';
import 'package:local_mart/repo/product_repo.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final ProductRepo _productRepo = ProductRepo();
  late Future<List<ProductModel>> _wishlistFuture;

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  void _loadWishlist() {
    setState(() {
      _wishlistFuture = _productRepo.fetchWishlist();
    });
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
            children: [
              Text(
                "Wishlist",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              Icon(Icons.favorite_border, color: Appcolors.white),
            ],
          ),
        ),
      ),

      body: _buildWishlist(),

      bottomNavigationBar: CustomBottomnavigationbar(
        currentIndex: 3,
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

  Widget _buildWishlist() {
    return FutureBuilder<List<ProductModel>>(
      future: _wishlistFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Wishlist is empty"));
        }

        final products = snapshot.data!;

        return GridView.builder(
          padding: EdgeInsets.all(14),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return Card(
              color: Appcolors.white,
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      product.imageUrl,
                      height: 85,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "${product.price}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.successGreen,
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: "Add",
                            height: 35,
                            fontSize: 12,
                            borderRadius: 8,
                            onTap: () async {
                              _productRepo.addToCart(product.id);
                            },
                          ),
                        ),

                        SizedBox(width: 6),

                        IconButton(
                          onPressed: () async {
                            await _productRepo.toggleLike(product.id);

                            _loadWishlist();
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
