import 'package:flutter/material.dart';
import '../views/user_page.dart';

class Bai1App extends StatelessWidget {
  const Bai1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 1: Fetch User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const UserPage(),
    );
  }
}
