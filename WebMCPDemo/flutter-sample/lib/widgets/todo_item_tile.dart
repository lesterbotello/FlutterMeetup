import 'package:flutter/material.dart';
import 'package:flutter_sample/models/todo.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/models/data.dart';
import 'package:intl/intl.dart';

class TodoItemTile extends StatelessWidget {
  final Todo todo;

  const TodoItemTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Checkbox
          GestureDetector(
            onTap: () {
              context.read<DataRepository>().toggleTodo(todo.id);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 2, right: 12),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: todo.isCompleted
                      ? const Color(0xFFDB4C3F)
                      : Colors.black38,
                  width: 1.5,
                ),
                color: todo.isCompleted
                    ? const Color(0xFFDB4C3F)
                    : Colors.transparent,
              ),
              child: todo.isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: todo.isCompleted ? Colors.black38 : Colors.black87,
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                if (todo.dueDate != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: Colors.green[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('h:mm a').format(todo.dueDate!),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Project Label
          if (todo.project != null)
            Row(
              children: [
                Text(
                  todo.project!.name,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(width: 4),
                Icon(Icons.tag, size: 12, color: todo.project!.color),
              ],
            ),
        ],
      ),
    );
  }
}
