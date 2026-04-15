import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard_models.dart';

class ApiHelper {
  static const String userUrl = 'https://jsonplaceholder.typicode.com/users/1';
  static const String postsUrl = 'https://jsonplaceholder.typicode.com/posts?_limit=3';
  static const String productsUrl = 'https://fakestoreapi.com/products?limit=2';

  static Future<Map<String, dynamic>> getDashboardData() async {
    // Calling multiple APIs in parallel
    final results = await Future.wait([
      http.get(Uri.parse(userUrl)),
      http.get(Uri.parse(postsUrl)),
      http.get(Uri.parse(productsUrl)),
    ]);

    if (results.every((res) => res.statusCode == 200)) {
      final userData = json.decode(results[0].body);
      final postsData = json.decode(results[1].body) as List;
      final productsData = json.decode(results[2].body) as List;

      return {
        'user': UserModel.fromJson(userData),
        'posts': postsData.map((j) => PostModel.fromJson(j)).toList(),
        'products': productsData.map((j) => ProductModel.fromJson(j)).toList(),
      };
    } else {
      throw Exception('Failed to load some dashboard data');
    }
  }
}
