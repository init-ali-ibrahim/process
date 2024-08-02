import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:process/color.dart';

class profileUserNull_widget extends StatefulWidget {
  const profileUserNull_widget({super.key});

  @override
  State<profileUserNull_widget> createState() => _profileUserNull_widgetState();
}

class _profileUserNull_widgetState extends State<profileUserNull_widget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/logIn'),
          style: TextButton.styleFrom(
            backgroundColor: colorLight,
            minimumSize: Size(MediaQuery.of(context).size.width - 120, 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ),
          child: const Text(
            'Войти',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
