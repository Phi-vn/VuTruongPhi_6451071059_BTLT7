import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiHelper {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  static Future<UserModel> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<UserModel> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }
}
