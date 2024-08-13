import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:process/screens/profile/widgets/profileUserNotNull.dart';
import 'package:process/screens/profile/widgets/profileUserNull_widget.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  final _fire = FirebaseAuth.instance;

  late User? user = _fire.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: user != null ? const profileUserNotNull_widget() : const profileUserNull_widget(),
              ),
            ],
          ),
        ));
  }
}
