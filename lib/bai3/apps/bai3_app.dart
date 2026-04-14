import 'package:flutter/material.dart';
import '../views/create_post_page.dart';

class Bai3App extends StatelessWidget {
  const Bai3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 3: Create Post',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const CreatePostPage(),
    );
  }
}
