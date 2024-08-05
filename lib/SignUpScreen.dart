import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:process/color.dart';
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
        MaterialPageRoute(builder: (context) => navbar(initialPageIndex: 2)),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: colorDark,
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
                  'Регистрация',
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
                  'Пожалуйста, создайте аккаунт, чтобы продолжить',
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
                  labelText: 'Почта',
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
                  labelText: 'Пароль',
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
              const SizedBox(height: 50.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _signUp,
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }


  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // String _phoneNumber = '';
  // String _verificationId = '';
  // String _smsCode = '';
  //
  // Future<void> _verifyPhoneNumber() async {
  //   if (_phoneNumber.isEmpty) {
  //     // Обработка пустого номера
  //     return;
  //   }
  //
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: _phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //         // Обработка ошибки
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         setState(() {
  //           _verificationId = verificationId;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //     // Обработка ошибки
  //   }
  // }
  //
  // Future<void> _signInWithPhoneNumber() async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId,
  //       smsCode: _smsCode,
  //     );
  //     await _auth.signInWithCredential(credential);
  //     // Успешная регистрация
  //   } catch (e) {
  //     print(e.toString());
  //     // Обработка ошибки
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Регистрация')),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           IntlPhoneField(
  //             decoration: InputDecoration(labelText: 'Номер телефона'),
  //             initialCountryCode: 'KZ',
  //             onChanged: (phone) => setState(() => _phoneNumber = phone.completeNumber),
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: _verifyPhoneNumber,
  //             child: Text('Отправить код'),
  //           ),
  //           SizedBox(height: 20),
  //           TextField(
  //             keyboardType: TextInputType.number,
  //             decoration: InputDecoration(labelText: 'Код из SMS'),
  //             onChanged: (value) => setState(() => _smsCode = value),
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: _signInWithPhoneNumber,
  //             child: Text('Подтвердить'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }



}