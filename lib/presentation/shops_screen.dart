import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/custom_BottomNavigationBar.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/const/widgets/custom_button.dart';
import 'package:local_mart/model/product_model.dart';
import 'package:local_mart/presentation/CategoriesScreen.dart';
import 'package:local_mart/presentation/ProfileScreen.dart';
import 'package:local_mart/presentation/homeScreen.dart';
import 'package:local_mart/presentation/wishlist_screen.dart';
import 'package:local_mart/repo/product_repo.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final ProductRepo _productRepo = ProductRepo();
  late Future<List<ProductModel>> _productFuture;

  Set<int> _wishlistIds = {};

  @override
  void initState() {
    super.initState();
    _productFuture = _productRepo.fetchproducts();
    _wishlistIds = {};
    _loadWishlist();
  }

  void _loadWishlist() async {
    final ids = await _productRepo.fetchWishlistIds();

    setState(() {
      _wishlistIds = ids.cast<int>().toSet();
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
                "Shop",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.search, color: Colors.white),
            ],
          ),
        ),
      ),
      body: _buildProducts(),
      bottomNavigationBar: CustomBottomnavigationbar(
        currentIndex: 2,
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

  _buildProducts() {
    return FutureBuilder(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error : ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Products Not Found"));
        }

        final products = snapshot.data!;

        return GridView.builder(
          padding: EdgeInsets.all(14),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
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
                              final bool isSuccess = await _productRepo
                                  .addToCart(product.id);

                              if (isSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${product.name} Added"),
                                    backgroundColor: Appcolors.successGreen,
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        SizedBox(width: 6),

                        IconButton(
                          onPressed: () async {
                            setState(() {
                              if (_wishlistIds.contains(product.id)) {
                                _wishlistIds.remove(product.id);
                              } else {
                                _wishlistIds.add(product.id);
                              }
                            });

                            await _productRepo.toggleLike(product.id);
                          },

                          icon: Icon(
                            _wishlistIds.contains(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _wishlistIds.contains(product.id)
                                ? Colors.red
                                : Colors.grey,
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
