import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiHelper {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<PostModel>> fetchPosts(int page, int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl?_page=$page&_limit=$limit'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
