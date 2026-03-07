import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/models/data.dart';
import 'package:flutter_sample/models/todo.dart';
import 'package:flutter_sample/screens/home_screen.dart';
import 'package:flutter_sample/utils/js_interop_stub.dart'
    if (dart.library.js_interop) 'package:flutter_sample/utils/js_interop_web.dart';

void main() {
  final dataRepository = DataRepository();

  exportAddTodo((String title, [String? dueDateIso, String? projectId]) {
    DateTime? dueDate;
    if (dueDateIso != null && dueDateIso.isNotEmpty) {
      dueDate = DateTime.tryParse(dueDateIso);
    }

    final projectList = dataRepository.projects.where((p) => p.id == projectId);
    final project = projectList.isNotEmpty ? projectList.first : null;

    dataRepository.addTodo(
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        dueDate: dueDate,
        project: project,
      ),
    );
  });

  runApp(
    ChangeNotifierProvider.value(value: dataRepository, child: const TodoApp()),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoist Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFDB4C3F), // Todoist red
          primary: const Color(0xFFDB4C3F),
          surface: Colors.white,
          background: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        fontFamily: 'Inter', // Assuming standard clean font
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
