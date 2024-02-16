import 'package:flutter/material.dart';
import 'package:todolong/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todoList = [
    Todo(
      id: 1,
      title: 'Buy groceries',
      description: 'Go to the supermarket and buy essential items lorem loremloremloremloremlorem.',
      priority: 2,
      dueDate: DateTime.now(),
      parentId: null, // Không có parent
    ),
    Todo(
      id: 2,
      title: 'Buy vegetables',
      description: 'Get fresh vegetables for the week.',
      priority: 1,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      parentId: 1, // parentId của công việc này là 1
    ),
    Todo(
      id: 3,
      title: 'Buy fruits',
      description: 'Get a variety of fruits.',
      priority: 1,
      dueDate: DateTime.now().add(Duration(days: 1)),
      parentId: 1, // parentId của công việc này cũng là 1
    ),
    Todo(
      id: 4,
      title: 'Complete project',
      description: 'Finish the coding project by the deadline.',
      priority: 3,
      dueDate: DateTime.now(),
      parentId: null, // Không có parent
    ),
    Todo(
      id: 5,
      title: 'Write code',
      description: 'Implement the required features.',
      priority: 2,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      parentId: 4, // parentId của công việc này là 4
    ),
    Todo(
      id: 6,
      title: 'Test the application',
      description: 'Perform thorough testing.',
      priority: 2,
      dueDate: DateTime.now().add(Duration(days: 1)),
      parentId: 4, // parentId của công việc này cũng là 4
    ),
    Todo(
      id: 7,
      title: 'Test the application 2',
      description: 'Perform thorough testing.',
      priority: 2,
      dueDate: DateTime.now().add(Duration(days: -1)),
      parentId: 4, // parentId của công việc này cũng là 4
    ),
  ];

  // TodoProvider() {
  //   // Khởi tạo danh sách công việc ở đây, hoặc bạn có thể load từ một nguồn dữ liệu khác.
  //   _todoList = [
  //     Todo(
  //       id: 1,
  //       title: 'Buy groceries',
  //       description: 'Go to the supermarket and buy essential items.',
  //       priority: 2,
  //       dueDate: DateTime.now().add(const Duration(days: 1)),
  //       parentId: null, // Không có parent
  //     ),
  //     Todo(
  //       id: 2,
  //       title: 'Buy vegetables',
  //       description: 'Get fresh vegetables for the week.',
  //       priority: 1,
  //       dueDate: DateTime.now().add(const Duration(days: 1)),
  //       parentId: 1, // parentId của công việc này là 1
  //     ),
  //     Todo(
  //       id: 3,
  //       title: 'Buy fruits',
  //       description: 'Get a variety of fruits.',
  //       priority: 1,
  //       dueDate: DateTime.now().add(Duration(days: 1)),
  //       parentId: 1, // parentId của công việc này cũng là 1
  //     ),
  //     Todo(
  //       id: 4,
  //       title: 'Complete project',
  //       description: 'Finish the coding project by the deadline.',
  //       priority: 3,
  //       dueDate: DateTime.now().add(const Duration(days: 1)),
  //       parentId: null, // Không có parent
  //     ),
  //     Todo(
  //       id: 5,
  //       title: 'Write code',
  //       description: 'Implement the required features.',
  //       priority: 2,
  //       dueDate: DateTime.now().add(const Duration(days: 1)),
  //       parentId: 4, // parentId của công việc này là 4
  //     ),
  //     Todo(
  //       id: 6,
  //       title: 'Test the application',
  //       description: 'Perform thorough testing.',
  //       priority: 2,
  //       dueDate: DateTime.now().add(Duration(days: 1)),
  //       parentId: 4, // parentId của công việc này cũng là 4
  //     ),
  //   ];
  // }
  Todo getTodoById(int id) {
    Todo a = _todoList.firstWhere((todo) => todo.id == id);
    a.subtasks = _todoList.where((todo) => todo.parentId == id).toList();
    return a;
  }

  List<Todo> getTodayTodos() {
    List<Todo> tdlist = _todoList
        .where((todo) =>
            todo.dueDate!.year == DateTime.now().year &&
            todo.dueDate!.month == DateTime.now().month &&
            todo.dueDate!.day == DateTime.now().day)
        .toList();
    print(_todoList);
    print(tdlist);
    for (var todo in tdlist) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }
    return tdlist;
  }

  (List<Todo>, List<Todo>) getTodayTodos2() {
    List<Todo> todayTodo = [];
    List<Todo> overdueTodo = [];

    _todoList.forEach((todo) {
      if (todo.dueDate != null) {
        if (todo.dueDate!.year == DateTime.now().year &&
            todo.dueDate!.month == DateTime.now().month &&
            todo.dueDate!.day == DateTime.now().day) {
          todayTodo.add(todo);
        } else if (todo.dueDate!.isBefore(DateTime.now())) {
          overdueTodo.add(todo);
        }
      }
    });

    for (var todo in todayTodo) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }

    for (var todo in overdueTodo) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }

    return (todayTodo, overdueTodo);
  }

  List<Todo> getAllTodos() {
    List<Todo> tdlist = _todoList;
    for (var todo in tdlist) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }
    return tdlist;
  }

  List<Todo> getUpcomingTodos() {
    // Lọc ra danh sách công việc có ngày hết hạn trong tương lai
    List<Todo> tdlist = _todoList
        .where((todo) => todo.dueDate!.isAfter(DateTime.now()))
        .toList();
    for (var todo in tdlist) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }
    return tdlist;
  }

  void addTodo(Todo todo) {
    int maxId = _todoList.isNotEmpty
        ? _todoList.map((e) => e.id!).reduce((a, b) => a > b ? a : b)
        : 0;

    todo.id = maxId + 1;
    todo.addedDate = DateTime.now();

    _todoList.add(todo);

    notifyListeners();
  }

  void updateTodo(int id, Todo updatedTodo) {
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todoList[index] = updatedTodo;
      notifyListeners();
    }
  }

  void deleteTodo(int id) {
    _todoList.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
