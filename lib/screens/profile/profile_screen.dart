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

  var colorIcon = Color(0xFF915F5F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F9),
          title: const Text(
            'Профиль',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Icon(
                  Icons.account_circle,
                  size: 150,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: user != null ? const profileUserNotNull_widget() : const profileUserNull_widget(),
              ),
              const SizedBox(height: 30),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                height: 172,
                decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xFFE5E5E5)), borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.countertops, color: colorIcon),
                          onTap: () {

                          },
                          title: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Город'), Text('Алматы', style: TextStyle(fontSize: 12),) ],),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: colorIcon,
                          ),
                          tileColor: Colors.white,
                        ),
                        const Divider(
                          height: 1,
                          color: Color(0xFFE5E5E5),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.edit_attributes,
                            color: colorIcon,
                          ),
                          onTap: () {
                            // Navigator.pushNamed(context, '/noCart');
                          },
                          // title: const Text('Язык'),
                          title: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Язык'), Text('Русский', style: TextStyle(fontSize: 12),) ],),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: colorIcon,
                          ),
                          tileColor: Colors.white,
                        ),
                        const Divider(
                          height: 1,
                          color: Color(0xFFE5E5E5),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.headphones,
                            color: colorIcon,
                          ),
                          onTap: () {

                          },
                          title: const Text('Поддержка'),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: colorIcon,
                          ),
                          tileColor: Colors.white,
                        ),

                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  '@Samal Cakes - 2024',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),
              
              // InkWell(
              //   onTap: (){},
              //   child: Image.asset('assets/iconDelivery.png'),
              // )
              
            ],
          ),
        ));
  }
}
