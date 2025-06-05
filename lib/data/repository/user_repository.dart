import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:logger/logger.dart';

class UserRepository {
  Future<Map<String, dynamic>> join(String username, String email, String password) async {
    final requestBody = {
      "username": username,
      "email": email,
      "password": password,
    };
    Response response = await dio.post("/join", data: requestBody); // await 붙이면 Response <T> 타입, 안 붙이면 Future 타입임
    final responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;
  }
}
