import 'package:dio/dio.dart';
import 'package:local_mart/model/product_model.dart';

class ProductRepo {
  final Dio _dio = Dio();

  static const String baseUrl =
      "https://local-mart-backend-9gbo.onrender.com/api";

  Future<List<ProductModel>> fetchproducts() async {
    try {
      final response = await _dio.get("$baseUrl/products");

      final List list = response.data["data"];

      return list.map((item) => ProductModel.fromJson(item)).toList();
    } catch (e) {
      print("Fetch Error: $e");
      return [];
    }
  }

  Future<bool> addToCart(int productId) async {
    try {
      final response = await _dio.post(
        "$baseUrl/cart/add-simple",
        data: {"ProductId": productId, "quantitty": 1},
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Add To Cart Error : $e");
      return false;
    }
  }

  Future<List> fetchWishlistIds() async {
    try {
      final response = await _dio.get("$baseUrl/wishlist/ids-simple");
      return response.data["ids"] ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> toggleLike(int productId) async {
    try {
      final response = await _dio.post(
        "$baseUrl/wishlist/toggle-simple",
        data: {"productId": productId},
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Toggle Wishlist Error : $e");
    }
    return false;
  }

  Future<List<ProductModel>> fetchWishlist() async {
    try {
      final response = await _dio.get("$baseUrl/wishlist/simple");

      final List list = response.data["data"] ?? [];

      return list.map((item) => ProductModel.fromJson(item)).toList();
    } catch (e) {
      print("fetch wishlist error : $e");
    }

    return [];
  }

  Future<List<ProductModel>> fetchCart() async {
    try {
      final response = await _dio.get("$baseUrl/cart/simple");

      final List list = response.data["data"] ?? [];

      return list.map((item) => ProductModel.fromJson(item)).toList();
    } catch (e) {
      print("Fetch Cart Error : $e");
      return [];
    }
  }

  Future<bool> removeFromCart(int productId) async {
    try {
      final response = await _dio.delete(
        "$baseUrl/cart/remove-simple/$productId",
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Remove From Cart Error: $e");
      return false;
    }
  }
}
