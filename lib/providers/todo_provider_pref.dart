import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/utils/notification/notification_service.dart';
import 'package:todolong/utils/strings/compare.dart';

class TodoProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  final String _todoKey = 'todos';

  List<Todo> _todoList = [];

  TodoProvider() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    List<String>? jsonTodos = _prefs.getStringList(_todoKey);
    if (jsonTodos != null && jsonTodos.isNotEmpty) {
      _todoList =
          jsonTodos.map((json) => Todo.fromJson(jsonDecode(json))).toList();
      notifyListeners();

      print(jsonTodos.map((json) => Todo.fromJson(jsonDecode(json))).toList());
    } else {
      // Khởi tạo mảng Todo ban đầu nếu không có dữ liệu trong SharedPreferences
      DateTime now = DateTime.now();
      DateTime? dueDate;
      dueDate = DateTime(now.year, now.month, now.day);
      await addTodo(Todo(
        id: 1,
        title: 'Buy groceries',
        description:
            'Go to the supermarket and buy essential items lorem loremloremloremloremlorem.',
        priority: 2,
        dueDate: dueDate,
        parentId: null,
        isCompleted: 0, // Không có parent
      ));
      await addTodo(Todo(
        id: 2,
        title: 'Buy vegetables',
        description: 'Get fresh vegetables for the week.',
        priority: 1,
        dueDate: DateTime.now().add(const Duration(days: 1)),
        isCompleted: 0, // Không có parent
        parentId: 1, // parentId của công việc này là 1
      ));
      await addTodo(Todo(
        id: 3,
        title: 'Buy fruits',
        description: 'Get a variety of fruits.',
        priority: 1,
        dueDate: dueDate,
        isCompleted: 0, // Không có parent
        parentId: 1, // parentId của công việc này cũng là 1
      ));

      await addTodo(Todo(
        id: 4,
        title: 'Complete project',
        description: 'Finish the coding project by the deadline.',
        priority: 3,
        dueDate: dueDate,
        isCompleted: 0, // Không có parent
        parentId: null, // Không có parent
      ));

      await addTodo(Todo(
        id: 5,
        title: 'Write code',
        description: 'Implement the required features.',
        priority: 2,
        dueDate: dueDate.add(const Duration(days: 1)),
        isCompleted: 0, // Không có parent
        parentId: 4, // parentId của công việc này là 4
      ));

      await addTodo(Todo(
        id: 6,
        title: 'Test the application',
        description: 'Perform thorough testing.',
        priority: 2,
        dueDate: dueDate.add(Duration(days: 1)),
        isCompleted: 0, // Không có parent
        parentId: 4, // parentId của công việc này cũng là 4
      ));

      await addTodo(Todo(
        id: 7,
        title: 'Test the application 2',
        description: 'Perform thorough testing.',
        priority: 2,
        dueDate: dueDate.add(Duration(days: -1)),
        isCompleted: 0, // Không có parent
        parentId: 4, // parentId của công việc này cũng là 4
      ));

      await addTodo(Todo(
        id: 8,
        title: 'Test the application 2',
        description: 'Perform thorough testing.',
        priority: 2,
        dueDate: dueDate.add(Duration(days: 7)),
        isCompleted: 0, // Không có parent
        parentId: null, // parentId của công việc này cũng là 4
      ));

      await addTodo(Todo(
        id: 9,
        title: 'Test the application 2',
        description: 'Perform thorough testing.',
        priority: 2,
        dueDate: dueDate.add(Duration(days: 8)),
        isCompleted: 0, // Không có parent
        parentId: null, // parentId của công việc này cũng là 4
      ));

      await addTodo(Todo(
        id: 10,
        title: 'Test the application 2',
        description: 'Perform thorough testing.',
        priority: 2,
        dueDate: dueDate.add(Duration(days: 9)),
        isCompleted: 0, // Không có parent
        parentId: null, // parentId của công việc này cũng là 4
      ));

      _saveTodos();
      notifyListeners();
    }
  }

  // Các phương thức khác của TodoProvider vẫn giữ nguyên không thay đổi

  Future<void> _saveTodos() async {
    List<String> encoded =
        _todoList.map((todo) => jsonEncode(todo.toJson())).toList();
    await _prefs.setStringList(_todoKey, encoded);
  }

  Future<void> addTodo(Todo todo) async {
    int maxId = _todoList.isNotEmpty
        ? _todoList.map((e) => e.id!).reduce((a, b) => a > b ? a : b)
        : 0;

    todo.id = maxId + 1;
    todo.addedDate = DateTime.now();

    if (todo.reminder != null) {
      await NotificationService().addScheduledNotification(todo);
    }
    _todoList.add(todo);
    _saveTodos();
    notifyListeners();
  }

  Future<void> updateTodo(int id, Todo updatedTodo) async {
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todoList[index] = updatedTodo;
      NotificationService().adjustScheduleNotification(updatedTodo);
      _saveTodos();
      notifyListeners();
    }
  }

  Future<void> completeTodo(int id) async {
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todoList[index].isCompleted = 1;
      NotificationService().removeScheduledNotifications(id);
      _saveTodos();
      notifyListeners();
    }
  }

  Future<void> deleteTodo(int id) async {
    _todoList.removeWhere((todo) => todo.id == id);
    NotificationService().removeScheduledNotifications(id);
    _saveTodos();
    notifyListeners();
  }

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
    tdlist.sort((a, b) {
      if (a.priority != b.priority) {
        return b.priority
            .compareTo(a.priority); // Sắp xếp theo ưu tiên giảm dần
      } else {
        return a.addedDate!.compareTo(
            b.addedDate!); // Nếu ưu tiên bằng nhau, sắp xếp theo addedDate
      }
    });
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

    for (var todo in _todoList) {
      if (todo.dueDate != null && todo.isCompleted == 0) {
        if (todo.dueDate!.year == DateTime.now().year &&
            todo.dueDate!.month == DateTime.now().month &&
            todo.dueDate!.day == DateTime.now().day) {
          todayTodo.add(todo);
        } else if (todo.dueDate!.isBefore(DateTime.now())) {
          overdueTodo.add(todo);
        }
      }
    }
    todayTodo.sort((a, b) {
      if (a.priority != b.priority) {
        return a.priority
            .compareTo(b.priority); // Sắp xếp theo ưu tiên giảm dần
      } else {
        return a.addedDate!.compareTo(
            b.addedDate!); // Nếu ưu tiên bằng nhau, sắp xếp theo addedDate
      }
    });
    overdueTodo.sort((a, b) {
      if (a.priority != b.priority) {
        return a.priority
            .compareTo(b.priority); // Sắp xếp theo ưu tiên giảm dần
      } else {
        return a.addedDate!.compareTo(
            b.addedDate!); // Nếu ưu tiên bằng nhau, sắp xếp theo addedDate
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
    List<Todo> tdlist = List.from(_todoList);
    for (var todo in tdlist) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }
    // tdlist.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    tdlist.sort((a, b) {
      if (a.priority != b.priority) {
        return a.priority
            .compareTo(b.priority); // Sắp xếp theo ưu tiên giảm dần
      } else {
        return a.addedDate!.compareTo(
            b.addedDate!); // Nếu ưu tiên bằng nhau, sắp xếp theo addedDate
      }
    });
    print(tdlist.length);
    return tdlist;
  }

  Map<DateTime, List<Todo>> getAllTodos2() {
    print("notified");
    Map<DateTime, List<Todo>> groupedTodos = {};

    for (var todo in _todoList) {
      if (todo.isCompleted == 1) continue;
      DateTime date =
          DateTime(todo.dueDate!.year, todo.dueDate!.month, todo.dueDate!.day);
      if (!groupedTodos.containsKey(date)) {
        groupedTodos[date] = [];
      }
      groupedTodos[date]!.add(todo);
    }
    var sortedByValueMap = Map.fromEntries(groupedTodos.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));
    return sortedByValueMap;
  }

  Map<DateTime, List<Todo>> getUpcomingTodos() {
    // Lọc ra danh sách công việc có ngày hết hạn trong tương lai
    Map<DateTime, List<Todo>> groupedTodos = {};
    List<Todo> tdlist = List.from(_todoList);

    tdlist = tdlist
        .where((todo) =>
            todo.dueDate!.isAfter(DateTime.now()) && todo.isCompleted == 0)
        .toList();

    for (var todo in tdlist) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }
    tdlist.sort((a, b) {
      if (a.priority != b.priority) {
        return a.priority
            .compareTo(b.priority); // Sắp xếp theo ưu tiên giảm dần
      } else {
        return a.addedDate!.compareTo(
            b.addedDate!); // Nếu ưu tiên bằng nhau, sắp xếp theo addedDate
      }
    });
    for (var todo in tdlist) {
      DateTime date =
          DateTime(todo.dueDate!.year, todo.dueDate!.month, todo.dueDate!.day);
      if (!groupedTodos.containsKey(date)) {
        groupedTodos[date] = [];
      }
      groupedTodos[date]!.add(todo);
    }
    var sortedByValueMap = Map.fromEntries(groupedTodos.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));
    return sortedByValueMap;
    // tdlist.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
  }

  (List<Todo>, List<Todo>) searchTodoByTitle(String searchStr) {
    List<Todo> td = List.from(_todoList);
    td = td.where((e) => e.isCompleted == 0).toList();
    for (var todo in td) {
      todo.subtasks = _todoList.where((t) => t.parentId == todo.id).toList();
    }
    List<Todo> titleMatch = [];
    List<Todo> descMatch = [];
    for (var todo in td) {
      if (todo.title.contains(searchStr)) {
        titleMatch.add(todo);
      }
      if (todo.description != null) {
        if (todo.description!.contains(searchStr)) {
          descMatch.add(todo);
        }
      }
      // double t1 = CompareString.calculateSimilarity(todo.title, searchStr);
      // var d1 = todo.description != null
      //     ? CompareString.calculateSimilarity(todo.description!, searchStr)
      //     : null;
      // if (t1 > 0.3) {
      //   titleMatch.add(todo);
      // }
      // if (d1 != null) {
      //   if (d1 > 0.3) {
      //     descMatch.add(todo);
      //   }
      // }
    }
    return (titleMatch, descMatch);
  }
}
