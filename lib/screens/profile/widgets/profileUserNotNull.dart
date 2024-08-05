import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:process/color.dart';
import 'package:process/viewCart.dart';

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
        Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery
              .of(context)
              .size
              .width - 20,
          height: 58,
          decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xFFE5E5E5)), borderRadius: const BorderRadius.all(Radius.circular(6))),
          child: Column(
            children: [
              Expanded(
                child: ListView(children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.cake,),
                    onTap: () {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewCartDataScreen(user: user),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Пользователь не найден.')),
                        );
                      }
                    },
                    title: const Text('Ваши cake'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    tileColor: Colors.white,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
