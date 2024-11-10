import 'package:authenticate/Screens/pages/home.dart';
import 'package:authenticate/Screens/pages/increment.dart';
import 'package:authenticate/Screens/pages/taskPage.dart';
import 'package:authenticate/controllers/languages.dart';
import 'package:authenticate/Screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      translations: Language(),
      fallbackLocale: Locale('en','US'),
      locale: Locale('en','US'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: TaskPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> images = [
    'https://i.ibb.co/Tk5LsB4/facebook-logo-hd.png',
    'https://i.ibb.co/vB3ZpGY/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png',
    'https://i.ibb.co/qYf3k7n/github-logo-1.png'
  ];

  List<String> socialTexts = ["Login with Facebook", "Login with Google", "Login with GitHub"];

  final _formKey = GlobalKey<FormState>();

  // Controllers to get values
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isChecked = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          SizedBox(height: 40,),
                          ShowCover()]),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Username',
                                  labelText: 'Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Username cannot be empty";
                                  }
                                  if (!RegExp(r'^[a-zA-Z0-9@.]+$').hasMatch(value)) {
                                    return "Username can only contain letters, numbers, and @";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: !_confirmPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Confirm password',
                                  labelText: 'Confirm Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible = !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Confirm Password cannot be empty";
                                  }
                                  if (value != _passwordController.text) {
                                    return "Passwords do not match";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              InkWell(
                                onTap: _isChecked
                                    ? () {
                                  if (_formKey.currentState!.validate()) {
                                    nSubmit();
                                  }
                                }
                                    : null,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _isChecked ? Colors.indigoAccent[200] : Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account?'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
                                    },
                                    child: const Text('Log in'),
                                  ),
                                ],
                              ),
                              CheckboxListTile(
                                value: _isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isChecked = newValue!;
                                  });
                                },
                                title: const Text('I agree to the terms and conditions'),
                                dense: true,
                                controlAffinity: ListTileControlAffinity.leading,
                              ),
                              const SizedBox(height: 20),
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
                              const SizedBox(height: 20),
                              BottomRow(),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget ShowCover() {
    return Column(
      children: const [
        SizedBox(height: 20),
        Icon(Icons.layers, size: 50, color: Colors.white),
        SizedBox(height: 10),
        Text(
          'Let\'s create an account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Signing up is quick and easy, bringing you one step closer to enjoying all our features.',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget BottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(images.length, (index) {
        return Row(
          children: [
            SizedBox(width: 30),
            SocialIcon(index: index), // Pass index to SocialIcon
          ],
        );
      }),
    );
  }

  Widget SocialIcon({required int index}) {
    return InkWell(
      onTap: () {
        if (index == 1) {
          // If the Google icon is tapped, sign in with Google
          signInWithGoogle().then((UserCredential credential) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Google sign-in failed: $error')),
            );
          });
        }
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 17,
        child: ClipOval(
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Firebase user creation function
  void nSubmit() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: ${e.message}')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  // Google Sign-In function
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
