import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiHelper {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Let's take only first 20 for better demo
      return data.take(20).map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch articles');
    }
  }
}
