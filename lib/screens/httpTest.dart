  import 'dart:convert';
  import 'package:flutter/material.dart';
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
        Uri.parse('http://192.168.0.219/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      print('response');
      if (response.statusCode == 200) {
        print('нормально');
      } else {
        print('говно: ${response.body}');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'имя'),
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
                  decoration: InputDecoration(labelText: 'Email'),
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
                  decoration: InputDecoration(labelText: 'Password'),
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      register(_name, _email, _password);
                    }
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
