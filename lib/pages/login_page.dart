import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset('assets/logo.png', width: 100), // Logo
            SizedBox(height: 20),
            Text('Kukhuri Kaa',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to Sign-Up page
                Navigator.pushNamed(context, '/signup');
              },
              child: Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
