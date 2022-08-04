import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_api_provider/model/post_model.dart';

class IPostService extends ChangeNotifier {
  Dio dio = Dio();
  Future<List<PostModel>> fetchPostItem() async {
    try {
      var path = "https://jsonplaceholder.typicode.com/posts";
      final responce =
          await dio.get(path);
      if (responce.statusCode == HttpStatus.ok) {
        final postBody = responce.data;
        if (postBody is List) {
          return postBody.map((e) => PostModel.fromJson(e)).toList();
        }
      }
      return [];
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}
