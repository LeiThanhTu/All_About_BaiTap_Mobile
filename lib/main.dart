import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hàng chứa các icon ở trên
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   _buildIconButton(Icons.arrow_back),
                  _buildIconButton(Icons.edit),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            const Spacer(), // Đẩy nội dung xuống giữa màn hình
            // Ảnh đại diện
            
              CircleAvatar(
                radius: 55,
                 backgroundImage: AssetImage("assets/images/avatar.jpg"),
              ),

            const SizedBox(height: 20),

            // Tên người dùng
            const Text(
              "Thanh Tú",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 5),

            // Địa chỉ
            const Text(
              "Ho Chi Minh City, Vietnam",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Spacer(flex: 2), // Đẩy nội dung lên giữa
          ],
        ),
      ),
    );
  }

   Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () {},
      ),
    );
  }
}
