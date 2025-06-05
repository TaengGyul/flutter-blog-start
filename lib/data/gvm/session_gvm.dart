import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/utils/validator_util.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/ui/pages/auth/join_page/join_fm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// 1. 창고 관리자
final sessionProvider = NotifierProvider<SessionGVM, SessionModel>(() {
  return SessionGVM();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class SessionGVM extends Notifier<SessionModel> {
  final mContext = navigatorKey.currentContext!;

  @override
  SessionModel build() {
    return SessionModel();
  }

  // 이게 하나의 트랜잭션이다
  Future<void> join(String username, String email, String password) async {
    // 남의 창고에 조회해 볼 수 있다 (유효성 검사)
    Logger().d("username : ${username}, email : ${email}, password : ${password}");
    bool isValid = ref.read(joinProvider.notifier).validate();
    if (!isValid) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("유효성 검사 실패입니다.")),
      );
      return;
    }

    Map<String, dynamic> body = await UserRepository().join(username, email, password);
    if (!body["success"]) {
      // 토스트 띄우기
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${body["errorMessage"]}")),
      );
      return;
    }

    // 성공하면 로그인 페이지로
    Navigator.pushNamed(mContext, "/login");
  }

  Future<void> login(String username, String password) async {}

  Future<void> logout() async {}
}

/// 3. 창고 데이터 타입
class SessionModel {
  int? id;
  String? username;
  String? accessToken;
  bool? isLogin;

  SessionModel({this.id, this.username, this.accessToken, this.isLogin = false});
}
