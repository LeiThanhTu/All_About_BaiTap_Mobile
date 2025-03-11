import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý Thư viện')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Chuyển đến danh sách sách
              },
              child: Text('Danh sách sách'),
            ),
            ElevatedButton(
              onPressed: () {
                // Chuyển đến danh sách người dùng
              },
              child: Text('Danh sách người dùng'),
            ),
          ],
        ),
      ),
    );
  }
}