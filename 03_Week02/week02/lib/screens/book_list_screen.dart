import 'package:flutter/material.dart';
import '../models/book.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final List<Book> books = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  void _addBook() {
    final title = titleController.text;
    final author = authorController.text;

    if (title.isNotEmpty && author.isNotEmpty) {
      setState(() {
        books.add(Book(title, author));
        titleController.clear();
        authorController.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm Sách'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Tác giả'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: _addBook,
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
        title: Text('Danh sách sách'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddBookDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index].title),
            subtitle: Text(books[index].author),
          );
        },
      ),
    );
  }
}