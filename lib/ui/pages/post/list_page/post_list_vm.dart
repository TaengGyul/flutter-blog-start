import 'package:flutter/material.dart' show ScaffoldMessenger, Text, SnackBar, Navigator;
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/model/user.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/ui/pages/auth/join_page/join_fm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// 1. 창고 관리자
final postListProvider = NotifierProvider<PostListVM, PostListModel?>(() {
  return PostListVM();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class PostListVM extends Notifier<PostListModel?> {
  final mContext = navigatorKey.currentContext!;

  @override
  PostListModel? build() {
    init();
    return null;
  }

  Future<void> init({int page = 0}) async {}
}

/// 3. 창고 데이터 타입 (불변 아님)
class PostListModel {
  bool isFirst;
  bool isLast;
  int pageNumber;
  int size;
  int totalPage;
  List<Post> posts;

  PostListModel(this.isFirst, this.isLast, this.pageNumber, this.size, this.totalPage, this.posts);

  @override
  String toString() {
    return 'PostListModel{isFirst: $isFirst, isLast: $isLast, pageNumber: $pageNumber, size: $size, totalPage: $totalPage, posts: $posts}';
  }
}
