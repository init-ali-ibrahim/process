import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:process/screens/color.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _togglePasswordVisibilityR() {
    setState(() {
      _obscureTextR = !_obscureTextR;
    });
  }

  bool _obscureText = true;
  bool _obscureTextR = true;

  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: { "#": RegExp(r'[0-9]') },
  );


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  String? _errorNameMessage;
  String? _errorLastnameMessage;
  String? _errorPasswordMessage;
  String? _errorPasswordRMessage;
  String? _errorNumberMessage;
  String? _errorEmailMessage;

  void _validateNameInput() {
    setState(() {
      if (_nameController.text.isEmpty) {
        _errorNameMessage = 'Это поле обязательно для заполнения';
      } else {
        _errorNameMessage = null;
      }
    });
  }
  void _validateLastnameInput() {
    setState(() {
      if (_lastNameController.text.isEmpty) {
        _errorLastnameMessage = 'Это поле обязательно для заполнения';
      } else {
        _errorLastnameMessage = null;
      }
    });
  }
  void _validateNumberInput() {
    setState(() {
      if (_nameController.text.isEmpty) {
        _errorNumberMessage = 'Это поле обязательно для заполнения';
      } else {
        _errorNumberMessage = null;
      }
    });
  }
  void _validateEmailInput() {
    setState(() {
      if (_nameController.text.isEmpty) {
        _errorEmailMessage = 'Это поле обязательно для заполнения';
      } else {
        _errorEmailMessage = null;
      }
    });
  }


  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    String cleanedPhone = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');

    final response = await http.post(
      Uri.parse('https://admin.samalcakes.kz/api/v1/auth/register'),
      headers: <String, String>{"Content-Type": "application/json; charset=UTF-8", "Accept": "application/json"},
      body: jsonEncode(<String, String>{
        'name': _nameController.text,
        'last_name': _lastNameController.text,
        'phone': cleanedPhone,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _passwordConfirmationController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: data['token']);

        String? tokenAuth = await storage.read(key: 'token');
        print(tokenAuth);
        print('Registration successful: ${data['message']}');

        Navigator.of(context).pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);
      } else {
        setState(() {
          _errorMessage = data['message'];
        });
        print('Error from server: ${data['message']}');
      }
    } else {
      setState(() {
        _errorMessage = 'Ошибка при регистрации. Пожалуйста, попробуйте снова.';
      });
      print('Server error: ${response}');
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
                          'Чтобы создать аккаунт, заполните форму',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Введите имя',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: 'Введите фамилию',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _phoneController,
                          inputFormatters: [maskFormatter],
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            labelText: 'Введите номер телефона',
                            hintText: '+7 (700) 000-00-00',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
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
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: _obscureTextR,
                          controller: _passwordConfirmationController,
                          decoration: InputDecoration(
                            labelText: 'Повторите пароль',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureTextR ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: _togglePasswordVisibilityR,
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
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
                              _register();
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
                              style: const TextStyle(color: Colors.red),
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
