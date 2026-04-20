import 'package:flutter/material.dart';

import '../views/task_list_page.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1F7A8C),
        scaffoldBackgroundColor: const Color(0xFFF6F9FC),
      ),
      home: const TaskListPage(),
    );
  }
}