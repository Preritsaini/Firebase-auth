import 'package:authenticate/Screens/pages/newpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authenticate/Screens/auth/login.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final args;
  const HomeScreen({super.key, this.args});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigoAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.energy_savings_leaf,
                color: Colors.white,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We are glad to have you here!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.to(NewPage());
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () async {
                  // Sign out the user
                  await FirebaseAuth.instance.signOut();

                  // Navigate back to the login screen
                  Get.toNamed('/');
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'log Out',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
