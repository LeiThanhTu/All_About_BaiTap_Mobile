import 'package:flutter/material.dart';

class ComponentCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const ComponentCard({
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4.0), // Adjusted margin
        padding: const EdgeInsets.all(12.0), // Adjusted padding
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ), // Adjusted font size
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ), // Adjusted font size
            ),
          ],
        ),
      ),
    );
  }
}
