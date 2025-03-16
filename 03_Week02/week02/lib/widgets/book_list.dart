import 'package:flutter/material.dart';

class BookListWidget extends StatefulWidget {
  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<String> books = ["Sách 01", "Sách 02"];
  List<bool> selectedBooks = [false, false];
  TextEditingController _bookController = TextEditingController();

  void _addBook() {
    if (_bookController.text.isNotEmpty) {
      setState(() {
        books.add(_bookController.text);
        selectedBooks.add(false);
      });
      _bookController.clear();
    }
  }

  void _removeBook(int index) {
    setState(() {
      books.removeAt(index);
      selectedBooks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Danh sách sách", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...List.generate(books.length, (index) {
          return ListTile(
            leading: Checkbox(
              value: selectedBooks[index],
              onChanged: (value) {
                setState(() {
                  selectedBooks[index] = value!;
                });
              },
            ),
            title: Text(books[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeBook(index),
            ),
          );
        }),
        TextField(
          controller: _bookController,
          decoration: InputDecoration(labelText: "Nhập tên sách mới"),
        ),
        SizedBox(height: 10),
        ElevatedButton(onPressed: _addBook, child: Text("Thêm")),
      ],
    );
  }
}
