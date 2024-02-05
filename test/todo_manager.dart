import 'dart:convert';
import 'dart:io';

import 'package:todolong/models/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolong/utils/strings/compare.dart';

class TodoManager {
  // static late String filePath;

  Future<String> _getLocalPath() async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory(); //FOR iOS
    return directory!.path;
  }

  Future<File> get _localFile async {
    final path = await _getLocalPath();
    return File('$path/todosLocal.dat');
  }

  Future<void> addTodo(Todo todo) async {
    try {
      final List<Todo> todos = await readTodos();
      int maxId = todos.isNotEmpty
          ? todos.map((e) => e.id).reduce((a, b) => a > b ? a : b)
          : 0;
      todo.id = maxId + 1;
      todos.add(todo);
      await _writeTodos(todos);
    } catch (e) {
      print('Error writing todo: $e');
    }
  }

  Future<Todo?> getTodoById(int id) async {
    try {
      final List<Todo> todos = await readTodos();
      return todos.firstWhere((todo) => todo.id == id);
    } catch (e) {
      print('Error reading todo: $e');
      return null;
    }
  }

  Future<List<Todo>?> getTodoByTitle(String title) async {
    try {
      final List<Todo> todos = await readTodos();
      List<Todo> filteredTodos = [];

      for (var todo in todos) {
        if (CompareString.calculateSimilarity(title, todo.title) > 0.6) {
          filteredTodos.add(todo);
        }
      }

      return filteredTodos;
    } catch (e) {
      print('Error reading todo: $e');
      return null;
    }
  }

  Future<List<Todo>> getTodosForToday() async {
    final List<Todo> todos = await readTodos();
    final today = DateTime.now();
    return todos.where((todo) => isSameDay(todo.dueDate, today)).toList();
  }

  Future<List<Todo>> getAllTodos() async {
    return await readTodos();
  }

  

  Future<List<Todo>> readTodos() async {
    try {
      final file = await _localFile;
      // final file = File(TodoManager.filePath);
      if (file.existsSync()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => Todo.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error reading todos: $e');
      return [];
    }
  }

  Future<void> _writeTodos(List<Todo> todos) async {
    final jsonTodos = todos.map((todo) => todo.toJson()).toList();
    final jsonString = jsonEncode(jsonTodos);
    final file = await _localFile;
    await file.writeAsString(jsonString);
  }
  bool isSameDay(DateTime? date1, DateTime date2) {
    return date1?.year == date2.year && date1?.month == date2.month && date1?.day == date2.day;
  }
}
