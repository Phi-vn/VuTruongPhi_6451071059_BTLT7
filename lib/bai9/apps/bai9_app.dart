import 'package:flutter/material.dart';
import '../views/news_list_page.dart';

class Bai9App extends StatelessWidget {
  const Bai9App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 9: Cache API Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const NewsListPage(),
    );
  }
}
