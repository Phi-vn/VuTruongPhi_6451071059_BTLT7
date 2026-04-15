import 'package:flutter/material.dart';
import '../views/feed_page.dart';

class Bai8App extends StatelessWidget {
  const Bai8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 8: Pagination',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FeedPage(),
    );
  }
}
