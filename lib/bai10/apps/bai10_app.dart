import 'package:flutter/material.dart';
import '../views/dashboard_page.dart';

class Bai10App extends StatelessWidget {
  const Bai10App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 10: Combine Multiple APIs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}
