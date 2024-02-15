import 'package:todolong/models/comment.dart';

class Todo {
  int? id;
  String title;
  String? description;
  int priority;
  Duration? reminder;
  String? location;
  List<String>? labels;
  List<Todo>? subtasks;
  DateTime? addedDate = DateTime.now();
  DateTime? dueDate;
  List<Comment>? comments;
  int? parentId;
  Todo(
      {this.id,
      required this.title,
      this.description,
      required this.priority,
      this.reminder,
      this.location,
      this.labels,
      this.subtasks,
      this.dueDate,
      this.parentId});

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'] as String?,
        priority = json['priority'] as int,
        reminder = json['reminder'] != null
            ? Duration(milliseconds: json['reminder'] as int)
            : null,
        location = json['location'] as String?,
        labels =
            (json['labels'] as List?)?.map((label) => label as String).toList(),
        subtasks = (json['subtasks'] as List?)
            ?.map((subtask) => Todo.fromJson(subtask))
            .toList(),
        addedDate = json['addedDate'] != null
            ? DateTime.parse(json['addedDate'] as String)
            : null,
        dueDate = json['dueDate'] != null
            ? DateTime.parse(json['dueDate'] as String)
            : null,
        parentId = json['parentId'] as int?;
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'reminder': reminder?.inMilliseconds,
        'location': location,
        'labels': labels,
        'subtasks': subtasks?.map((subtask) => subtask.toJson()).toList(),
        'addedDate': addedDate?.toIso8601String(),
        'dueDate': dueDate?.toIso8601String(),
        'parentId': parentId,
      };
}
