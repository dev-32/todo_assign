import 'dart:convert';

import 'package:todo_assign/constant/api_url.dart';
import 'package:todo_assign/models/posts_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<PostsDataModel>?> loadPosts() async {
    final response = await http.get(Uri.parse(AppApiUrls.postUrls));

    try {
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList.map((json) => PostsDataModel.fromJson(json)).toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<PostsDataModel>?> searchPosts(String userId) async {
    final response =
        await http.get(Uri.parse(AppApiUrls.searchPostUrl + userId));
    try {
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList.map((json) => PostsDataModel.fromJson(json)).toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
