import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/api_helper.dart';
import '../widgets/product_info.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Product> futureProduct;

  @override
  void initState() {
    super.initState();
    futureProduct = ApiHelper.fetchProduct(1); // Fetch product ID 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MSSV: 6451071059'),
        backgroundColor: Colors.teal.shade100,
        centerTitle: true,
      ),
      body: FutureBuilder<Product>(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Error: ${snapshot.error}', textAlign: TextAlign.center),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found'));
          }

          return SingleChildScrollView(
            child: ProductInfo(product: snapshot.data!),
          );
        },
      ),
    );
  }
}
