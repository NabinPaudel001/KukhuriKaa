import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kukhurikaa/pages/dashboard_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _signUp() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
      return;
    }

    try {
      // Register the user using email and password
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, // Use email provided by the user
        password: _passwordController.text,
      );
      // Navigate to the home screen or next page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
        (route) => false,
      ); // This ensures all previous routes are removed); // Replace with your home screen
    } on FirebaseAuthException catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? 'An error occurred'),
      ));
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                      "assets/kukhuriKaa_logo_transparent_splash.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Kukhuri Kaa',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Chicken Monitoring App',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 40),
                // TextField(
                //   // controller: _fullNameController,
                //   decoration: InputDecoration(
                //     labelText: 'Full Name',
                //     prefixIcon: Icon(Icons.person),
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                // SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: Theme.of(context).inputDecorationTheme.border,
                    focusedBorder: Theme.of(context)
                        .inputDecorationTheme
                        .focusedBorder
                        ?.copyWith(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    prefixIcon:
                        Icon(Icons.mail, color: Theme.of(context).primaryColor),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 16),
                  cursorColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: Theme.of(context).inputDecorationTheme.border,
                    focusedBorder: Theme.of(context)
                        .inputDecorationTheme
                        .focusedBorder
                        ?.copyWith(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    prefixIcon: Icon(Icons.password,
                        color: Theme.of(context).primaryColor),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(fontSize: 16),
                  cursorColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your Password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: Theme.of(context).inputDecorationTheme.border,
                    focusedBorder: Theme.of(context)
                        .inputDecorationTheme
                        .focusedBorder
                        ?.copyWith(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    prefixIcon: Icon(Icons.password,
                        color: Theme.of(context).primaryColor),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(fontSize: 16),
                  cursorColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 40),
                _isLoading
                    ? Center(
                        child:
                            CircularProgressIndicator()) // Show loader when logging in
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
