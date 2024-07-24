import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:process/color.dart';

class profileUserNotNull_widget extends StatefulWidget {
  const profileUserNotNull_widget({super.key});

  @override
  State<profileUserNotNull_widget> createState() => _profileUserNotNull_widgetState();
}

class _profileUserNotNull_widgetState extends State<profileUserNotNull_widget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Привет, вы зашли',
          style: TextStyle(fontSize: 20, color: Colors.pinkAccent),
        ),
        TextButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signOut();

              // setState(() {
              //
              // });


              // Future.delayed(const Duration(seconds: 3), () {
              //   Navigator.of(context, rootNavigator: true).push(
              //     MaterialPageRoute(
              //       builder: (_) => const LoginScreen(),
              //     ),
              //   );
              // });

            } on Exception catch (e) {
              print(e);
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: colorLight,
            minimumSize: Size(MediaQuery.of(context).size.width - 120, 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ),
          child: const Text(
            'Выйти',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
