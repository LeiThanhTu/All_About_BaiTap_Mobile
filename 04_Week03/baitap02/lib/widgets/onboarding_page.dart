import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isSplash;
  final bool isLast;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    this.isSplash = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: isSplash 
            ? MainAxisAlignment.center 
            : MainAxisAlignment.start,
        children: [
          if (isSplash) ...[
            // UTH Logo
            Image.asset(
              'assets/logo_school.png',
              height: 80,
            ),
            const SizedBox(height: 16),
            // App name with custom styling
            Text(
              title,
              style: const TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF00A19D), // UTH brand color from image
              ),
            ),
          ] else ...[
            const SizedBox(height: 40),
            // Feature illustration
            Image.asset(
              image,
              height: 240,
            ),
            const SizedBox(height: 32),
            // Feature title
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Feature description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}