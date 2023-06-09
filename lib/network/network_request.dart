import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movie_api/models/post.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static const String apiEndpoint = 'https://jsonplaceholder.typicode.com/posts';
  static Uri url = Uri.parse(apiEndpoint);

  static List<Post> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Post> posts = list.map((model) => Post.fromMap(model)).toList();
    return posts;
  }

  static Future<List<Post>> fetchPosts({int page = 1}) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get posts');
    }
  }
}



