import '../models/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/keys.dart';

class ApiService {
  Future<List<Todo>> fetchTodos() async {
    try {
      final response = await http.get(
        Uri.parse(Keys.baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return [];
        }
        final List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          return [];
        }
        return data.map((json) => Todo.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
