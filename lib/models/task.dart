import 'dart:convert';

class Task {
  String id;
  String title;
  String description;
  int priority;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      id: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      priority: jsonData['priority'],
      dueDate: DateTime.parse(jsonData['dueDate']),
      isCompleted: jsonData['isCompleted'],
    );
  }

  static Map<String, dynamic> toMap(Task task) => {
        'id': task.id,
        'title': task.title,
        'description': task.description,
        'priority': task.priority,
        'dueDate': task.dueDate.toIso8601String(),
        'isCompleted': task.isCompleted,
      };

  static String encode(List<Task> tasks) => json.encode(
        tasks
            .map<Map<String, dynamic>>((task) => Task.toMap(task))
            .toList(),
      );

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Task>((item) => Task.fromJson(item))
          .toList();
}
