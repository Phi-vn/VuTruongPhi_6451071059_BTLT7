import 'package:flutter/material.dart';

class PostResult extends StatelessWidget {
  final String result;

  const PostResult({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) return const SizedBox.shrink();

    final isError = result.contains('Error');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isError ? Colors.red.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? Colors.red : Colors.green,
        ),
      ),
      child: Text(
        result,
        style: TextStyle(
          color: isError ? Colors.red : Colors.green.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
