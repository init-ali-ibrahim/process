import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:process/screens/navbar.dart';
import 'package:process/screens/profile/profile_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _logIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => navbar(initialPageIndex: 2)),
      // );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => navbar(initialPageIndex: 2)),
        (Route<dynamic> route) => false,
      );

      print('зашли?');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Color(0xFF772067),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          flexibleSpace: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Please enter your email to continue',
                  style: TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Color(0x13621455),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Color(0x13621455),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      // Icons.visibility_off
                    ),
                    onPressed:
                        // () => widget
                        _togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Забыли пароль?',
                    style: TextStyle(color: Color(0xFF953282)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF953282),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _logIn,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              const Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(thickness: 1.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Or войти через'),
                  ),
                  Expanded(
                    child: Divider(thickness: 1.0),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/google.png',
                      height: 24.0,
                    ),
                    label: const Text('Google'),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Еще нет аккаунта? ',
                    ),
                    GestureDetector(
                      onTap: () {Navigator.pushNamed(context, '/signUp');},
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF953282),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
