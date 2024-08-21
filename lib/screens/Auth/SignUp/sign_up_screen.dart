import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:process/screens/color.dart';
import 'package:process/screens/navbar.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Navbar(initialPageIndex: 2)),
        (Route<dynamic> route) => false,
      );
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
        backgroundColor: bgColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height - 90,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Icon(Icons.cake, color: Colors.red, size: 40),
                            SizedBox(width: 10),
                            Text(
                              'Новый аккаунт',
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Чтобы создать аккаунт, введите почту и пароль',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        // const SizedBox(height: 20),
                        // TextField(
                        //   decoration: InputDecoration(
                        //     labelText: 'Введите имя',
                        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        // TextField(
                        //   decoration: InputDecoration(
                        //     prefixIcon: const Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 12),
                        //       child: Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           SizedBox(width: 5),
                        //           Text('+7'),
                        //         ],
                        //       ),
                        //     ),
                        //     labelText: 'Введите номер телефона',
                        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Введите почту',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            // labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                          ),
                        ),
                        // const SizedBox(height: 20),
                        // TextField(
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: 'Повторите пароль',
                        //     suffixIcon: const Icon(Icons.visibility_off),
                        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(text: 'Нажимая Далее, вы принимаете условия ', style: TextStyle(color: Colors.black54)),
                              TextSpan(
                                text: 'Политики конфиденциальности',
                                style: const TextStyle(color: Colors.red),
                                recognizer: TapGestureRecognizer()..onTap = () {},
                              ),
                              const TextSpan(text: ' и ', style: TextStyle(color: Colors.black54)),
                              TextSpan(
                                text: 'Пользовательского соглашения',
                                style: const TextStyle(color: Colors.red),
                                recognizer: TapGestureRecognizer()..onTap = () {},
                              ),
                              const TextSpan(text: ' и даете согласие на обработку персональных данных', style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _signUp();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              maximumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                              minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: const Text(
                            'Далее',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(text: 'Уже есть аккаунт? ', style: TextStyle(color: Colors.black54)),
                              TextSpan(
                                text: 'Войти',
                                style: const TextStyle(color: Colors.red),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/logIn');
                                  },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ))));
  }
}
