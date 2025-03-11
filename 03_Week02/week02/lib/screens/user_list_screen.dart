import 'package:flutter/material.dart';
import '../models/user.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final List<User> users = [];
  final TextEditingController nameController = TextEditingController();

  void _addUser() {
    final name = nameController.text;

    if (name.isNotEmpty) {
      setState(() {
        users.add(User(name));
        nameController.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm Người Dùng'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Tên'),
          ),
          actions: [
            TextButton(
              onPressed: _addUser,
              child: Text('Thêm'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách người dùng'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddUserDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
          );
        },
      ),
    );
  }
}