import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoService {
  static const String baseUrl = "http://172.30.137.245:7000/user";

  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse("$baseUrl/get"));
    final List data = jsonDecode(response.body);
    return data.map((e) => Todo.fromJson(e)).toList();
  }

  static Future<void> addTodo(String title, String description) async {
    await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "decription": description,
      }),
    );
  }

  static Future<void> updateTodo(String id, String title, String description) async {
    await http.post(
      Uri.parse("$baseUrl/update-one-by-title"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": id,
        "title": title,
        "decription": description,
      }),
    );
  }

  static Future<void> deleteTodo(String id) async {
    await http.delete(
      Uri.parse("$baseUrl/delete"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id}),
    );
  }
}
