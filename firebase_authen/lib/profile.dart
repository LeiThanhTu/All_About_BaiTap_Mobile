import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // We're making some assumptions about the user data for the example
    // In a real app, you might want to handle missing data more gracefully
    final String displayName = user.displayName ?? 'Melissa Peters';
    final String email = user.email ?? 'melpeters@gmail.com';
    final String dob = '23/05/1995'; // Example data as Firebase doesn't store DOB by default

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile image
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : NetworkImage('https://via.placeholder.com/150'),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.camera_alt, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 40),
            
            // Profile details form
            ProfileField(label: 'Name', value: displayName),
            SizedBox(height: 16),
            ProfileField(label: 'Email', value: email),
            SizedBox(height: 16),
            ProfileField(
              label: 'Date of Birth', 
              value: dob,
              isDropdown: true,
            ),
            
            Spacer(),
            
            // Back button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final bool isDropdown;

  const ProfileField({
    super.key, 
    required this.label, 
    required this.value, 
    this.isDropdown = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              if (isDropdown) Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ],
    );
  }
}