import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:process/screens/color.dart';
import 'package:process/screens/connection.dart';
import 'package:process/screens/navbar.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String? _errorPhoneMessage;
  String? _errorPasswordMessage;

  void _validatePhoneInput() {
    setState(() {
      if (_phoneController.text.isEmpty) {
        _errorPhoneMessage = 'Это поле обязательно для заполнения';
      } else {
        _errorPhoneMessage = null;
      }
    });
  }

  void _validatePasswordInput() {
    setState(() {
      if (_passwordController.text.isEmpty) {
        _errorPasswordMessage = 'Это поле обязательно для заполнения';
      } else {
        _errorPasswordMessage = null;
      }
    });
  }


  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String cleanedPhone = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');

    final response = await http.post(
      Uri.parse('https://admin.samalcakes.kz/api/v1/auth/login'),
      headers: <String, String>{"Content-Type": "application/json; charset=UTF-8", "Accept": "application/json"},
      body: jsonEncode(<String, String>{
        'phone': cleanedPhone,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: data['token']);

        String? lox = await storage.read(key: 'token');
        print(lox);
        print('Login successful: ${data['message']}');
        Navigator.of(context).pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);
      } else {
        setState(() {
          _errorMessage = data['message'];
        });
        print('Error from server: ${data['message']}');
      }
    } else {
      setState(() {
        _errorMessage = 'Не удалось войти в систему. Пожалуйста, попробуйте снова.';
      });
      print('Server error: ${response.body}');
    }
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
        body: ConnectivityChecker(
            child: SingleChildScrollView(
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
                                  'Войти',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Введите номер и пароль',
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [maskFormatter],
                              decoration: InputDecoration(
                                errorText: _errorPhoneMessage,
                                hintText: '+7 (700) 000-00-00',
                                labelText: 'Введите номер телефона',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                labelText: 'Пароль',
                                errorText: _errorPasswordMessage,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                                child: const Text(
                              'Забыли пароль?',
                              style: TextStyle(color: Colors.red),
                            )),
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
                            if (_isLoading)
                              const CircularProgressIndicator()
                            else
                              ElevatedButton(
                                onPressed: () {
                                  _validatePasswordInput();
                                  _validatePhoneInput();

                                  if (_errorPasswordMessage == null && _errorPhoneMessage == null) {
                                    _login();
                                  }
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
                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: Colors.red), textAlign: TextAlign.center,
                                ),
                              ),
                            const SizedBox(height: 20),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(text: 'Нет аккаунта? ', style: TextStyle(color: Colors.black54)),
                                  TextSpan(
                                    text: 'Зарегистрироваться',
                                    style: const TextStyle(color: Colors.red),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, '/signUp');
                                      },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      ],
                    )))));
  }
}
