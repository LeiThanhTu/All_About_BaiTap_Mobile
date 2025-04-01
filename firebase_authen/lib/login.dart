import 'package:firebase_authen/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(color: Colors.blue.shade100),
                child: Center(
                  child: Text(
                    'UTH',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // App Name
              Text(
                'SmartTasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              Text(
                'A simple and efficient to-do app',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              SizedBox(height: 50),

              // Welcome text
              Text(
                'Welcome',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Text(
                'Ready to explore? Log in to get started.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              SizedBox(height: 30),

              // Google Sign in button
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    onPressed: _signInWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://www.google.com/favicon.ico',
                          height: 24,
                        ),
                        SizedBox(width: 12),
                        Text('SIGN IN WITH GOOGLE'),
                      ],
                    ),
                  ),

              SizedBox(height: 40),

              // Copyright text
              Text(
                '© UTHSmartTasks',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in flow
        _showMessage('Sign in canceled');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create new credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // Successfully signed in
      _showMessage('Sign in successful!');

      // Navigate to profile screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(user: userCredential.user!),
        ),
      );
    } catch (e) {
      _showMessage('Error during sign in: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
