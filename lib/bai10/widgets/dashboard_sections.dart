import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';

class UserSection extends StatelessWidget {
  final UserModel user;
  const UserSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(user.email),
      ),
    );
  }
}

class PostSection extends StatelessWidget {
  final List<PostModel> posts;
  const PostSection({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Posts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...posts.map((post) => Card(
          child: ListTile(
            leading: const Icon(Icons.article, color: Colors.blue),
            title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        )).toList(),
      ],
    );
  }
}

class ProductSection extends StatelessWidget {
  final List<ProductModel> products;
  const ProductSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Featured Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...products.map((product) => Card(
          child: ListTile(
            leading: Image.network(product.image, width: 40, height: 40, fit: BoxFit.contain),
            title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Text('\$${product.price}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        )).toList(),
      ],
    );
  }
}
