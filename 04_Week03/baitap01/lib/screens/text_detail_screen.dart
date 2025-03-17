import 'package:flutter/material.dart';

class TextDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Text Detail",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 32, color: Colors.black),
            children: [
              TextSpan(
                text: "The ",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: "quick ",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(
                text: "Brown\n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              TextSpan(
                text: "fox ",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: "j",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              WidgetSpan(child: SizedBox(width: 8)),
              TextSpan(
                text: "u",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              WidgetSpan(child: SizedBox(width: 8)),
              TextSpan(
                text: "m",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              WidgetSpan(child: SizedBox(width: 8)),
              TextSpan(
                text: "p",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              WidgetSpan(child: SizedBox(width: 8)),
              TextSpan(
                text: "s ",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: "over\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "the ",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: "lazy ",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(
                text: "dog.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
