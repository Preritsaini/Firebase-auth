import 'package:authenticate/Screens/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign-In package
import '../../main.dart';
import '../pages/home.dart';

class LoginScreen extends StatefulWidget {
  final args;
  const LoginScreen({super.key,this.args});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    widget.args["name"];
    super.initState();
  }
  List<String> images = [
    'https://i.ibb.co/Tk5LsB4/facebook-logo-hd.png',
    'https://i.ibb.co/vB3ZpGY/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png',
    'https://i.ibb.co/qYf3k7n/github-logo-1.png'
  ];
  List<String> socialTexts = ["Login with Facebook", "Login with Google", "Login with GitHub"];

  final TextEditingController _emailController = TextEditingController(); // Controller for email
  final TextEditingController _passwordController = TextEditingController(); // Controller for password


  final FirebaseAuth _auth = FirebaseAuth.instance;


  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function to handle Firebase sign-in
  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to the home screen if successful
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        // Display Snackbar for wrong password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password provided for that user.')),
        );
      } else {
        // Handle any other errors if necessary
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred')),
        );
      }
    }
  }

  // Function to handle Google Sign-In
  Future<void> _signInWithGoogle() async {
    try {

      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      await _auth.signInWithCredential(credential);

      // Navigate to the home screen if successful
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
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
                  Center(
                    child: Text(
                      'Hello! Welcome back',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 240),
                LoginBlock(),
                InkWell(
                  onTap: () => _login(), // Call the login function when tapped
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('or login with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 20),
                BottomRow(),
                Row(
                  children: [
                    SizedBox(width: 50),
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(title: ''),
                          ),
                        );
                      },
                      child: Text('Create account'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget LoginBlock() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Username or Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController, // Assign email controller
              decoration: InputDecoration(
                hintText: 'Enter email',
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email cannot be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'Enter Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController, // Assign password controller
              decoration: InputDecoration(
                hintText: 'Enter password',
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true, // To hide the password input
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Remember me'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetScreen(),
                      ),
                    );
                  },
                  child: Text('Forget password?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(images.length, (index) {
        return Row(
          children: [
            SizedBox(width: 30),
            index == 1 // Check if it is Google login
                ? GestureDetector(
              onTap: () {
                _signInWithGoogle(); // Call Google sign-in function
              },
              child: SocialIcon(index: index),
            )
                : SocialIcon(index: index),
          ],
        );
      }),
    );
  }

  Widget SocialIcon({required int index}) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 17, // Increased radius to make the avatar larger
      child: ClipOval(
        child: Image.network(
          images[index],
          fit: BoxFit.cover, // Ensures the image covers the CircleAvatar nicely
        ),
      ),
    );
  }
}
