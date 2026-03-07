import 'package:flutter/material.dart';

class Project {
  final String id;
  final String name;
  final Color color;

  const Project({required this.id, required this.name, required this.color});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'color': color.value};
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      name: json['name'] as String,
      color: Color(json['color'] as int),
    );
  }
}
