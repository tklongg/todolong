import 'package:flutter/material.dart';
import 'package:todolong/models/todo.dart';

class TodayTodoProvider extends ChangeNotifier {
  List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  TodayTodoProvider() {
    // Khởi tạo danh sách công việc ở đây, hoặc bạn có thể load từ một nguồn dữ liệu khác.
    _todoList = [
      Todo(
        id: 1,
        title: 'Buy groceries',
        description: 'Go to the supermarket and buy essential items.',
        priority: 2,
        dueDate: DateTime.now().add(const Duration(days: 1)),
        subtasks: [
          Todo(
            id: 2,
            title: 'Buy vegetables',
            description: 'Get fresh vegetables for the week.',
            priority: 1,
            dueDate: DateTime.now().add(const Duration(days: 1)),
            subtasks: [],
          ),
          Todo(
            id: 3,
            title: 'Buy fruits',
            description: 'Get a variety of fruits.',
            priority: 1,
            dueDate: DateTime.now().add(Duration(days: 1)),
            subtasks: [],
          ),
        ],
      ),
      Todo(
        id: 4,
        title: 'Complete project',
        description: 'Finish the coding project by the deadline.',
        priority: 3,
        dueDate: DateTime.now().add(const Duration(days: 1)),
        subtasks: [
          Todo(
            id: 5,
            title: 'Write code',
            description: 'Implement the required features.',
            priority: 2,
            dueDate: DateTime.now().add(const Duration(days: 1)),
            subtasks: [],
          ),
          Todo(
            id: 6,
            title: 'Test the application',
            description: 'Perform thorough testing.',
            priority: 2,
            dueDate: DateTime.now().add(Duration(days: 1)),
            subtasks: [],
          ),
        ],
      ),
    ];
  }

  // Các phương thức để thêm, sửa đổi và xóa công việc từ danh sách
  void addTodayTodo(Todo todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void updateTodayTodo(int id, Todo updatedTodo) {
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todoList[index] = updatedTodo;
      notifyListeners();
    }
  }

  void deleteTodayTodo(int id) {
    _todoList.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
