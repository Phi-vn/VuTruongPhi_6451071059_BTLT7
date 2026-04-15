import 'package:flutter/material.dart';
import '../views/update_user_page.dart';

class Bai4App extends StatelessWidget {
  const Bai4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 4: Update User Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const UpdateUserPage(),
    );
  }
}
