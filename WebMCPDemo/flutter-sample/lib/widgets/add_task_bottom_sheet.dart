import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sample/models/data.dart';
import 'package:flutter_sample/models/project.dart';
import 'package:flutter_sample/models/todo.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Project? _selectedProject;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    DateTime? dueDate;
    if (_selectedDate != null) {
      dueDate = _selectedDate;
      if (_selectedTime != null) {
        dueDate = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );
      }
    }

    addTodo(title, dueDate, _selectedProject);

    Navigator.pop(context);
  }

  void addTodo(String title, DateTime? dueDate, Project? project) {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      dueDate: dueDate,
      project: project,
    );

    context.read<DataRepository>().addTodo(newTodo);
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DataRepository>();
    if (_selectedProject == null && data.projects.isNotEmpty) {
      _selectedProject = data.projects.first;
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Task name',
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 18, color: Colors.black38),
            ),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChip(
                  icon: Icons.calendar_today,
                  label: _selectedDate == null
                      ? 'Today'
                      : DateFormat('MMM d').format(_selectedDate!),
                  onTap: _pickDate,
                ),
                const SizedBox(width: 8),
                _buildChip(
                  icon: Icons.access_time,
                  label: _selectedTime == null
                      ? 'Time'
                      : _selectedTime!.format(context),
                  onTap: _pickTime,
                ),
                const SizedBox(width: 8),
                _buildProjectDropdown(data.projects),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: Colors.black54),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black87, fontSize: 13),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      onPressed: onTap,
    );
  }

  Widget _buildProjectDropdown(List<Project> projects) {
    if (projects.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Project>(
          value: _selectedProject,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          onChanged: (Project? newValue) {
            setState(() {
              _selectedProject = newValue;
            });
          },
          items: projects.map<DropdownMenuItem<Project>>((Project project) {
            return DropdownMenuItem<Project>(
              value: project,
              child: Row(
                children: [
                  Icon(Icons.tag, size: 14, color: project.color),
                  const SizedBox(width: 4),
                  Text(project.name),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
