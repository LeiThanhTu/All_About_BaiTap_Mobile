import 'package:baitap01/widgets/component.card.dart';
import 'package:flutter/material.dart';

class ComponentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "UI Components List",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Adjusted padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Display",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjusted font size
              ),
              ComponentCard(
                title: "Text",
                description: "Displays text",
                onTap: () => Navigator.pushNamed(context, '/textDetail'),
              ),
              ComponentCard(
                title: "Image",
                description: "Displays an image",
                onTap: () => Navigator.pushNamed(context, '/imageDetail'),
              ),
              SizedBox(height: 8), // Adjusted spacing
              Text(
                "Input",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjusted font size
              ),
              ComponentCard(
                title: "TextField",
                description: "Input field for text",
                onTap: () => Navigator.pushNamed(context, '/textFieldDetail'),
              ),
              ComponentCard(
                title: "PasswordField",
                description: "Input field for passwords",
                onTap: () => Navigator.pushNamed(context, '/passwordFieldDetail'),
              ),
              SizedBox(height: 8), // Adjusted spacing
              Text(
                "Layout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjusted font size
              ),
              ComponentCard(
                title: "Column",
                description: "Arranges elements vertically",
                onTap: () => Navigator.pushNamed(context, '/columnDetail'),
              ),
              ComponentCard(
                title: "Row",
                description: "Arranges elements horizontally",
                onTap: () => Navigator.pushNamed(context, '/rowDetail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}