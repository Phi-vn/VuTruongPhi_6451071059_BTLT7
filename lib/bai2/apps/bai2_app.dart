import 'package:flutter/material.dart';
import '../views/product_detail_page.dart';

class Bai2App extends StatelessWidget {
  const Bai2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 2: Product Detail',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const ProductDetailPage(),
    );
  }
}
