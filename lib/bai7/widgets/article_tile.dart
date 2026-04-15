import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            article.id.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            article.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        onTap: () {
          // Show details or toast
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reading: ${article.title}')),
          );
        },
      ),
    );
  }
}
