import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiHelper {
  // Fetch a single product detail
  static Future<Product> fetchProduct(int id) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product detail');
    }
  }
}
