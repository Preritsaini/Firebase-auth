import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verifyotp.dart'; // Ensure this imports your VerifyOtpScreen

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize FirebaseAuth
  String _message = ''; // To show messages to the user
  bool _isLoading = false; // To manage loading state

  Future<void> _sendOtp() async {
    String email = _emailController.text.trim();

    // Validate email format
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        _message = 'Please enter a valid email address.';
      });
      return;
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Navigate to the VerifyOtpScreen after sending the OTP
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerifyOtpScreen(email: email)),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = e.message ?? 'Error sending OTP. Please try again.'; // Show error message
      });
    } catch (e) {
      setState(() {
        _message = 'An unexpected error occurred. Please try again.'; // Generic error message
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Icon(Icons.lock_clock, color: Colors.white, size: 60),
                  Text(
                    'Enter your email',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  SizedBox(height: 300),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  // Button to send OTP
                  InkWell(
                    onTap: _isLoading ? null : _sendOtp, // Disable button if loading
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Send OTP',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Display message to the user
                  SizedBox(height: 20),
                  Text(
                    _message,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  // Loading indicator
                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
