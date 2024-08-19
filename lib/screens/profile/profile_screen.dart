import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:process/screens/profile/widgets/profileUserNotNull.dart';
import 'package:process/screens/profile/widgets/profileUserNull_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final storage = const FlutterSecureStorage();
  String? _token;
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    _loadToken();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      String? dataJson = await storage.read(key: 'data');
      if (dataJson != null) {
        setState(() {
          data = jsonDecode(dataJson);
        });
      }
    } catch (e) {
      print('Ошибка при загрузке данных: $e');
    }
  }

  Future<void> _loadToken() async {
    String? tokenDa = await storage.read(key: 'token');
    setState(() {
      _token = tokenDa;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: _token != null ? const profileUserNotNull_widget() : const profileUserNull_widget(),
              ),
            ],
          ),
        ));
  }
}
