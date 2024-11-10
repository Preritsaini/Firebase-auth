import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'change.dart'; // Ensure this imports your ChangePasswordScreen

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  String _message = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _verifyOtp() async {
    String otp = _otpController.text.trim();

    // Here you would implement your own logic for verifying the OTP if you have your own system
    // However, for Firebase, we need to navigate to the ChangePasswordScreen directly.

    if (otp.isEmpty) {
      setState(() {
        _message = 'Please enter the OTP.';
      });
      return;
    }

    // Navigate to the ChangePasswordScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordScreen(email: widget.email, otp: otp)), // Pass email and OTP if needed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 280,
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
                  SizedBox(height: 100),
                  Icon(Icons.password, color: Colors.white, size: 60),
                  SizedBox(height: 20),
                  Text(
                    'Enter OTP sent to ${widget.email}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 250),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      hintText: 'Enter OTP',
                      labelText: 'OTP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                // Button to verify OTP
                InkWell(
                  onTap: _verifyOtp,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Verify OTP',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
