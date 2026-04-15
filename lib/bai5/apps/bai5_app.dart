import 'package:flutter/material.dart';
import '../views/task_list_page.dart';

class Bai5App extends StatelessWidget {
  const Bai5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 5: Delete Item',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const TaskListPage(),
    );
  }
}
