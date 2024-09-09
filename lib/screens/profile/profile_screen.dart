import 'package:flutter/material.dart';
import 'package:process/screens/profile/widgets/profileUserAuth_widget.dart';
import 'package:process/screens/profile/widgets/profileUserNull_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = const FlutterSecureStorage();
  String? _token;

  @override
  void initState() {
    _loadToken();
    super.initState();
  }

  Future<void> _loadToken() async {
    String? tokenDa = await storage.read(key: 'token');
    setState(() {
      _token = tokenDa;
    });

    // try {
    //   final url = Uri.parse('http://192.168.1.109:80/api/v1/auth/check');
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       'Authorization': 'Bearer $tokenDa',
    //       'Content-Type': 'application/json',
    //     },
    //   );
    //
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //
    //   } else {
    //
    //   }
    //
    // } catch(e) {
    //   await storage.delete(key: 'token');
    // }
    //
    // setState(() {
    //   _token = tokenDa;
    // });
    //
    // print(_token);
    // print(tokenDa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: _token != null ? const profileUserAuth_widget() : const profileUserNull_widget(),
              ),
            ],
          ),
        ));
  }
}