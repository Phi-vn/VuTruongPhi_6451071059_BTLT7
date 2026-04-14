import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiHelper {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static Future<Post> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'body': body,
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }
}
