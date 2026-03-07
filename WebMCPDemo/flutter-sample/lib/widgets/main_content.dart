import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/models/data.dart';
import 'package:flutter_sample/models/todo.dart';
import 'package:flutter_sample/widgets/todo_item_tile.dart';
import 'package:flutter_sample/widgets/add_task_bottom_sheet.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DataRepository>();
    final todos = data.todos;

    final upcomingTodos = todos.where((t) => !t.isCompleted).toList();
    upcomingTodos.sort((a, b) {
      if (a.dueDate == null && b.dueDate == null) return 0;
      if (a.dueDate == null) return 1;
      if (b.dueDate == null) return -1;
      return a.dueDate!.compareTo(b.dueDate!);
    });

    final completeTodos = todos.where((t) => t.isCompleted).toList();
    completeTodos.sort((a, b) => b.id.compareTo(a.id));

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: ListView(
          children: [
            const Text(
              'Today',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context: context,
              title: 'Upcoming',
              todos: upcomingTodos,
              showAddButton: true,
            ),
            if (completeTodos.isNotEmpty) ...[
              const SizedBox(height: 32),
              _buildSection(
                context: context,
                title: 'Complete',
                todos: completeTodos,
                showAddButton: false,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<Todo> todos,
    required bool showAddButton,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const Divider(color: Color(0xFFEEEEEE), thickness: 1, height: 16),
        if (todos.isEmpty && showAddButton)
          _buildEmptyState()
        else
          ...todos.map((todo) => TodoItemTile(todo: todo)).toList(),
        if (showAddButton) ...[
          const SizedBox(height: 8),
          _buildAddTaskButton(context),
        ],
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, size: 48, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'All clear! Relax and enjoy your day.',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => const AddTaskBottomSheet(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: const [
            Icon(Icons.add, size: 18, color: Color(0xFFDB4C3F)),
            SizedBox(width: 8),
            Text(
              'Add task',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
