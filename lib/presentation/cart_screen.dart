import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:local_mart/const/widgets/custom_appBar.dart';
import 'package:local_mart/model/product_model.dart';
import 'package:local_mart/presentation/homeScreen.dart';
import 'package:local_mart/repo/product_repo.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductRepo _productRepo = ProductRepo();
  late Future<List<ProductModel>> _cartFuture;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() {
    setState(() {
      _cartFuture = _productRepo.fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.appBackground,
      appBar: CustomAppbar(
        backgroundColor: Appcolors.darkBlue,
        toolbarHeight: 90,
        showBackButton: false,
        titleWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Homescreen()),
                  );
                },
                icon: Icon(Icons.arrow_back),
              ),

              SizedBox(width: 5),

              Text(
                "My Cart",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: _buildCart(),
    );
  }

  Widget _buildCart() {
    return FutureBuilder(
      future: _cartFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Cart is empty"));
        }

        final products = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.all(14),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return Card(
              color: Appcolors.white,
              elevation: 1.5,
              margin: EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              child: Row(
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 65,
                    width: 65,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
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

                        IconButton(
                          onPressed: () async {
                            await _productRepo.removeFromCart(product.id);
                            _loadCart();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Appcolors.errorRed,
                            size: 24,
                          ),
                        ),
                      ],
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
