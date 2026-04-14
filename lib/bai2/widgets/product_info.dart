import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductInfo extends StatelessWidget {
  final Product product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              product.image,
              height: 250,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            product.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, color: Colors.teal, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Text(
            'Description:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
