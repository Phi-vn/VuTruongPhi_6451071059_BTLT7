import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiHelper {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  static Future<List<TaskModel>> getTasks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Let's take only first 15 for better demo
      return data.take(15).map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  static Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
