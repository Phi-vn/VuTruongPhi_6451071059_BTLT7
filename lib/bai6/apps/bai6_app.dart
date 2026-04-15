import 'package:flutter/material.dart';
import '../views/search_page.dart';

class Bai6App extends StatelessWidget {
  const Bai6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 6: Search API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SearchPage(),
    );
  }
}
