import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/models/data.dart';
import 'package:flutter_sample/widgets/add_task_bottom_sheet.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DataRepository>();

    return Container(
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(),
          const SizedBox(height: 16),
          _buildMenuItem(
            Icons.add_circle,
            'Add task',
            color: Theme.of(context).primaryColor,
            onTap: () => _showAddTaskDialog(context),
          ),
          _buildMenuItem(Icons.search, 'Search'),
          _buildMenuItem(Icons.inbox, 'Inbox'),
          _buildMenuItem(Icons.today, 'Today', isSelected: true),
          _buildMenuItem(Icons.calendar_month, 'Upcoming'),
          _buildMenuItem(Icons.tune, 'Filters & Labels'),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'My Projects',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: data.projects.length,
              itemBuilder: (context, index) {
                final project = data.projects[index];
                return _buildProjectItem(project.color, project.name);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const AddTaskBottomSheet(),
    );
  }

  Widget _buildUserHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/100?img=5',
            ), // Dummy avatar
          ),
          SizedBox(width: 8),
          Text('Denise', style: TextStyle(fontWeight: FontWeight.bold)),
          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
          Spacer(),
          Icon(Icons.notifications_none, size: 20, color: Colors.black54),
          SizedBox(width: 8),
          Icon(Icons.space_dashboard_outlined, size: 20, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    bool isSelected = false,
    Color? color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEFEA) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color:
                  color ??
                  (isSelected ? const Color(0xFFDB4C3F) : Colors.black54),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFFDB4C3F) : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectItem(Color color, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.circle, size: 12, color: color),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
