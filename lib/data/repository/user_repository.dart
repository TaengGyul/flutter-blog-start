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

  Future<Map<String, dynamic>> login(String username, String password) async {
    // 1. Map 변환
    final requestBody = {
      "username": username,
      "password": password,
    };

    // 2. 통신
    Response response = await dio.post("/login", data: requestBody); // await 붙이면 Response <T> 타입, 안 붙이면 Future 타입임
    Map<String, dynamic> responseBody = response.data;

    // 3. 헤더에서 토큰을 꺼내야 한다
    String accessToken = "";
    try {
      accessToken = response.headers["Authorization"]![0];
      responseBody["response"]["accessToken"] = accessToken;
    } catch (e) {}
    Logger().d(responseBody);
    return responseBody;
  }
}
