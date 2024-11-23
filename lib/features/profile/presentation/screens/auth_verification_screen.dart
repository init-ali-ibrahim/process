import 'package:flutter/material.dart';
import 'package:process/features/profile/presentation/screens/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/features/profile/presentation/screens/profile_screen.dart';

class AuthVerificationScreen extends StatefulWidget {
  const AuthVerificationScreen({super.key});

  @override
  State<AuthVerificationScreen> createState() => _AuthVerificationScreenState();
}

class _AuthVerificationScreenState extends State<AuthVerificationScreen> {
  final storage = const FlutterSecureStorage();
  String? _token;

  @override
  void initState() {
    _deleteToken();
    // _loadToken();
    super.initState();
  }

  // Future<void> _loadToken() async {
  //   String? tokenDa = await storage.read(key: 'token');
  //   setState(() {
  //     _token = tokenDa;
  //   });
  // }

  Future<void> _deleteToken() async {
    String? tokenDa = await storage.read(key: 'token');
    if (tokenDa != null) {
      await storage.delete(key: 'token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _token != null
        ? const ProfileScreen()
        : const LoginScreen());
  }
}
