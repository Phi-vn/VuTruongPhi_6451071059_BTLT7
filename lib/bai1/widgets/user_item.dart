import 'package:flutter/material.dart';
import '../models/user.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${user.id}'),
      ),
      title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(user.email),
    );
  }
}
