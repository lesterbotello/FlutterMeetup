import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sample/models/project.dart';
import 'package:flutter_sample/models/todo.dart';

class DataRepository extends ChangeNotifier {
  static const String _todosKey = 'todos_key';

  final List<Project> projects = [
    const Project(id: 'p1', name: 'Fitness', color: Colors.orange),
    const Project(id: 'p2', name: 'Appointments', color: Colors.blue),
    const Project(id: 'p3', name: 'Groceries', color: Colors.green),
    const Project(id: 'p4', name: 'Website Update', color: Colors.purple),
  ];

  List<Todo> todos = [];

  DataRepository() {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString(_todosKey);

    if (todosJson != null) {
      final List<dynamic> decodedList = jsonDecode(todosJson);
      todos = decodedList
          .map((item) => Todo.fromJson(item as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(
      todos.map((t) => t.toJson()).toList(),
    );
    await prefs.setString(_todosKey, encodedList);
  }

  void toggleTodo(String id) {
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(
        isCompleted: !todos[index].isCompleted,
      );
      notifyListeners();
      _saveTodos();
    }
  }

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
    _saveTodos();
  }
}
