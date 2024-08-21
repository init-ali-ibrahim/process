import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class httpTest extends StatefulWidget {
  const httpTest({super.key});

  @override
  State<httpTest> createState() => _httpTestState();
}

class _httpTestState extends State<httpTest> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  Future<void> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.219:80/api/register'),
      headers: <String, String>{"Content-Type": "application/json; charset=UTF-8", "Accept": "application/json"},
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "password": password,
      }),
    );
    const storage = FlutterSecureStorage();
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      await storage.write(key: 'data', value: jsonEncode(responseData['data']));
      await storage.write(key: 'token', value: responseData['token']);

      print('Data saved: ${responseData['data']}');
      print('Token saved: ${responseData['token']}');
    } else {
      print('говно: ${response.body}');
    }
  }

  // Future<void> lox() async {
  //   final response = await http.post(
  //     Uri.parse('https://smsc.kz/sys/send.php?login=alinusipbaev&psw=Ali145!4&phones=77770609644&mes=СODE'),
  //     headers: <String, String>{"Content-Type": "application/json; charset=UTF-8", "Accept": "application/json"},
  //     // body: jsonEncode(<String, String>{
  //     //   // "name": name,
  //     //   // "email": email,
  //     //   // "password": password,
  //     // }),
  //   );
  //   const storage = FlutterSecureStorage();
  //   if (response.statusCode == 200) {
  //     print('object');
  //   } else {
  //     print('cheert');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: SingleChildScrollView(
          child:    Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'имя'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'имя';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value ?? '';
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            register(_name, _email, _password);
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     lox();
              //   },
              //   child: const Text('lox'),
              // ),
            ],
          ),
        )
     );
  }
}
