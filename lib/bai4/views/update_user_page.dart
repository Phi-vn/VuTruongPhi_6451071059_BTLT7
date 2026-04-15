import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/api_helper.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({super.key});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final _formKey = GlobalKey<FormState>();
  UserModel? _user;
  bool _isLoading = true;
  bool _isUpdating = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final user = await ApiHelper.getUser(1);
      setState(() {
        _user = user;
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
        _websiteController.text = user.website;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading user: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isUpdating = true);
      try {
        final updatedUser = _user!.copyWith(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          website: _websiteController.text,
        );

        final result = await ApiHelper.updateUser(updatedUser);

        if (mounted) {
          setState(() {
            _user = result;
            _isUpdating = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Update Successful!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating user: $e')),
          );
          setState(() => _isUpdating = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User Info (MSSV: 6451071059)'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter name' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter email' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter phone' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _websiteController,
                      decoration: const InputDecoration(labelText: 'Website'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter website' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isUpdating ? null : _updateUser,
                      child: _isUpdating
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Update User Info'),
                    ),
                    if (_user != null && !_isUpdating) ...[
                      const SizedBox(height: 30),
                      const Text(
                        'Updated Result:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: ListTile(
                          title: Text(_user!.name),
                          subtitle: Text(
                              'Email: ${_user!.email}\nPhone: ${_user!.phone}\nWebsite: ${_user!.website}'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    super.dispose();
  }
}
