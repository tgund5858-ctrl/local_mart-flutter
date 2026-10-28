import 'package:dio/dio.dart';

class UserprofileeditRepo {
  final Dio _dio = Dio();

  Future<bool> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      final response = await _dio.put(
        "https://local-mart-backend-9gbo.onrender.com/api/users/quick-update",
        data: {"name": name, "phone": phone},
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      print("Error : $e");
      return false;
    }
  }
}
