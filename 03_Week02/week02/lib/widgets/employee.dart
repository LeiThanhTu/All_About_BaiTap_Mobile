import 'package:flutter/material.dart';

class EmployeeWidget extends StatefulWidget {
  @override
  _EmployeeWidgetState createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<EmployeeWidget> {
  String employeeName = "Nguyen Van A";
  TextEditingController _controller = TextEditingController();

  void _changeEmployeeName() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        employeeName = _controller.text;
      }
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nhân viên", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: "Nhập tên mới"),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: _changeEmployeeName, child: Text("Đổi"))
          ],
        ),
        SizedBox(height: 10),
        Text("Tên nhân viên: $employeeName", style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
