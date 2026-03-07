import 'package:flutter/material.dart';
import 'package:flutter_sample/widgets/sidebar.dart';
import 'package:flutter_sample/widgets/main_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Text('Today', style: TextStyle(color: Colors.black)),
            ),
      drawer: isDesktop ? null : const Drawer(child: Sidebar()),
      body: Row(
        children: [
          if (isDesktop) const SizedBox(width: 280, child: Sidebar()),
          const Expanded(child: MainContent()),
        ],
      ),
    );
  }
}
