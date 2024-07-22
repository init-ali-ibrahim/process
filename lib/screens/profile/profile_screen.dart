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
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F9),
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                child: user != null
                    ? const profileUserNotNull_widget()
                    : const profileUserNull_widget(),
              ),

              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 172,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: const Color(0xFFE5E5E5)),
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.headphones),
                          onTap: () {
                            const snackBar = SnackBar(
                              content: Text('Кнопка нажата (Lolas Carse)'),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          title: const Text('Lolas Care'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          tileColor: Colors.white,
                        ),
                        const Divider(
                          height: 1,
                          color: Color(0xFFE5E5E5),
                        ),
                        ListTile(
                          leading: const Icon(Icons.countertops),
                          onTap: () {
                            const snackBar = SnackBar(
                              content: Text('Кнопка нажата (Riyadh)'),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          title: const Text('Riyadh'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          tileColor: Colors.white,
                        ),
                        const Divider(
                          height: 1,
                          color: Color(0xFFE5E5E5),
                        ),
                        ListTile(
                          leading: const Icon(Icons.edit_attributes),
                          onTap: () {
                            const snackBar = SnackBar(
                              content: Text('Кнопка нажата (English)'),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          title: const Text('English'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          tileColor: Colors.white,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 30),
              // Container(
              //   width: MediaQuery.of(context).size.width - 20,
              //   height: 59,
              //   decoration: BoxDecoration(
              //       border: Border.all(width: 1, color: const Color(0xFFE5E5E5)),
              //       borderRadius: const BorderRadius.all(Radius.circular(10))),
              //   child: Column(
              //     children: [
              //       Expanded(
              //         child: ListView(children: <Widget>[
              //           ListTile(
              //             leading: const Icon(Icons.sd_storage),
              //             onTap: () {
              //               const snackBar = SnackBar(
              //                 content: Text('Кнопка нажата (Storage)'),
              //                 duration: Duration(seconds: 2),
              //               );
              //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //             },
              //             title: const Text('Storage'),
              //             trailing: const Icon(
              //               Icons.arrow_forward_ios,
              //               size: 16,
              //               color: Colors.grey,
              //             ),
              //             tileColor: Colors.white,
              //           ),
              //         ]),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  '@Lola - 2024',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              )
            ],
          ),
        ));
  }
}
