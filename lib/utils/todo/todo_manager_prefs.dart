import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/utils/strings/compare.dart';

class TodoFileManager {
  late SharedPreferences _prefs;

  TodoFileManager() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> addTodo(Todo todo) async {
    try {
      final List<Todo> todos = await readTodos();
      int maxId = todos.isNotEmpty
          ? todos.map((e) => e.id!).reduce((a, b) => a > b ? a : b)
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
      final Todo todo = todos.firstWhere((todo) => todo.id == id);
      todo.subtasks = todos.where((t) => t.parentId == id).toList();
      return todo;
    } catch (e) {
      print('Error reading todo: $e');
      return null;
    }
  }

  Future<List<Todo>?> getTodoByTitle(String title) async {
    try {
      List<Todo> todos = await readTodos();

      List<Todo> filteredTodos = [];

      for (var todo in todos) {
        if (CompareString.calculateSimilarity(title, todo.title) > 0.6) {
          filteredTodos.add(todo);
        }
      }
      for (var todo in todos) {
        todo.subtasks = todos.where((t) => t.parentId == todo.id).toList();
      }
      return filteredTodos;
    } catch (e) {
      print('Error reading todo: $e');
      return null;
    }
  }

  Future<List<Todo>> getTodosForToday() async {
    List<Todo> tdlist = await readTodos();
    List<Todo> todos2 = tdlist.where((e) => e.parentId != null).toList();
    todos2 = todos2
        .where((todo) =>
            todo.dueDate!.year == DateTime.now().year &&
            todo.dueDate!.month == DateTime.now().month &&
            todo.dueDate!.day == DateTime.now().day)
        .toList();
    for (var todo in todos2) {
      todo.subtasks = tdlist.where((t) => t.parentId == todo.id).toList();
    }
    return tdlist;
  }

  Future<List<Todo>> getAllTodos() async {
    List<Todo> tdlist = await readTodos();
    List<Todo> todos2 = tdlist.where((e) => e.parentId != null).toList();
    for (var todo in todos2) {
      todo.subtasks = tdlist.where((t) => t.parentId == todo.id).toList();
    }
    return await readTodos();
  }

  Future<List<Todo>> readTodos() async {
    try {
      final jsonString = _prefs.getString('todos') ?? '[]';
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Todo.fromJson(json)).toList();
    } catch (e) {
      print('Error reading todos: $e');
      return [];
    }
  }

  Future<void> _writeTodos(List<Todo> todos) async {
    final jsonTodos = todos.map((todo) => todo.toJson()).toList();
    final jsonString = jsonEncode(jsonTodos);
    await _prefs.setString('todos', jsonString);
  }

  bool isSameDay(DateTime? date1, DateTime date2) {
    return date1?.year == date2.year &&
        date1?.month == date2.month &&
        date1?.day == date2.day;
  }
}
