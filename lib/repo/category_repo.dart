import "package:dio/dio.dart";
import "package:local_mart/model/category_model.dart";

class CategoryRepo {
  static const String baseUrl =
      "https://local-mart-backend-9gbo.onrender.com/api";

  final Dio _dio = Dio();

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get("$baseUrl/categories");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["data"];
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception("Fail to load category");
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }
}
