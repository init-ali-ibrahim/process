import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
  }

  bool _obscureText = true;
  bool _obscureTextR = true;
  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Container(
            height: MediaQuery.of(context).size.height,
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
                      keyboardType: const TextInputType.numberWithOptions(),
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
                    ElevatedButton(
                      onPressed: () {},
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
                    // RichText(
                    //   textAlign: TextAlign.center,
                    //   text: TextSpan(
                    //     children: <TextSpan>[
                    //       const TextSpan(text: 'Уже есть аккаунт? ', style: TextStyle(color: Colors.black54)),
                    //       TextSpan(
                    //         text: 'Войти',
                    //         style: const TextStyle(color: Colors.red),
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () {
                    //             Navigator.pushNamed(context, '/logIn');
                    //           },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                  ],
                )
              ],
            )));
  }
}
