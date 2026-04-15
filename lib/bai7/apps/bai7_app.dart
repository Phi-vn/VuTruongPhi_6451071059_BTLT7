import 'package:flutter/material.dart';
import '../views/news_list_page.dart';

class Bai7App extends StatelessWidget {
  const Bai7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 7: Pull to Refresh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const NewsListPage(),
    );
  }
}
