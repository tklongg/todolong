class Todo {
  int id;
  String title;
  String? description;
  int priority;
  DateTime? reminder;
  String? location;
  List<String>? labels;
  List<Todo>? subtasks;
  DateTime? dueDate;
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.reminder,
    this.location,
    this.labels,
    this.subtasks,
    this.dueDate,
  });

  // factory Todo.fromJson(Map<String, dynamic> json) {
  //   return Todo(
  //     id: json['id'] as int,
  //     title: json['title'] as String,
  //     description: json['description'] as String?,
  //     priority: json['priority'] as int,
  //     reminder: json['reminder'] != null
  //         ? DateTime.parse(json['reminder'] as String)
  //         : null,
  //     location: json['location'] as String?,
  //     labels: (json['labels'] as List?)?.cast<String>(),
  //     subtasks: (json['subtasks'] as List?)?.cast<int>(),
  //     dueDate: json['dueDate'] != null
  //         ? DateTime.parse(json['dueDate'] as String)
  //         : null,
  //   );
  // }
  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'] as String?,
        priority = json['priority'] as int,
        reminder = json['reminder'] != null
            ? DateTime.parse(json['reminder'] as String)
            : null,
        location = json['location'] as String?,
        subtasks = (json['subtasks'] as List?)
            ?.map((subtask) => Todo.fromJson(subtask))
            .toList(),
        dueDate = json['dueDate'] != null
            ? DateTime.parse(json['dueDate'] as String)
            : null;
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'reminder': reminder?.toIso8601String(),
        'location': location,
        'labels': labels,
        'subtasks': subtasks?.map((subtask) => subtask.toJson()).toList(),
        'dueDate': dueDate?.toIso8601String(),
      };
}
