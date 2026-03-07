import 'package:flutter_sample/models/project.dart';

class Todo {
  final String id;
  final String title;
  final DateTime? dueDate;
  final Project? project;
  final bool isCompleted;

  const Todo({
    required this.id,
    required this.title,
    this.dueDate,
    this.project,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate?.toIso8601String(),
      'project': project?.toJson(),
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
      project: json['project'] != null
          ? Project.fromJson(json['project'] as Map<String, dynamic>)
          : null,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Todo copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    Project? project,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      project: project ?? this.project,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
