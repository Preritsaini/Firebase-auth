import 'package:authenticate/Screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key, required this.email, required this.otp}) : super(key: key);

  final String email; // Store email
  final String otp; // Store OTP

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _message = ''; // Variable to store status messages

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Update the user's password using the email provided in the OTP flow
        await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email);

        // After successfully sending the password reset email, update the password
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.email,
          password: _newPasswordController.text.trim(), // This is where you'd set the new password
        );

        setState(() {
          _message = 'Password changed successfully!';
        });

        // Navigate back to the LoginScreen after a delay
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, // Remove all previous routes
          );
        });
      } catch (e) {
        setState(() {
          _message = 'Error: ${e.toString()}'; // Show error message
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 30),
                Icon(Icons.password, color: Colors.blue, size: 30),
                SizedBox(height: 20),

                const SizedBox(height: 16),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                InkWell(
                  onTap: _changePassword, // Call change password function
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Change Password',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Display the message to the user
                Text(
                  _message,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
