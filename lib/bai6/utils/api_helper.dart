import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiHelper {
  static const String baseUrl = 'https://dummyjson.com/products/search';

  static Future<List<ProductModel>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}
