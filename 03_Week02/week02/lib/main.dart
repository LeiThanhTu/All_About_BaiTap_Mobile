import 'package:flutter/material.dart';
import 'package:week02/widgets/book_list.dart';
import 'package:week02/widgets/employee.dart';

void main() {
  runApp(LibraryApp());
}

class LibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LibraryHomePage(),
    );
  }
}

class LibraryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hệ thống Quản lý Thư viện"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmployeeWidget(),
            SizedBox(height: 20),
            BookListWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Quản lý"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "DS Sách"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Nhân viên"),
        ],
      ),
    );
  }
}