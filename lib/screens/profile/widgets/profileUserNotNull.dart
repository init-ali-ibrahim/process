import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/screens/order/order_screen.dart';

class profileUserNotNull_widget extends StatefulWidget {
  const profileUserNotNull_widget({super.key});

  @override
  State<profileUserNotNull_widget> createState() => _profileUserNotNull_widgetState();
}

class _profileUserNotNull_widgetState extends State<profileUserNotNull_widget> {

  final storage = const FlutterSecureStorage();
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Icon(
                              Icons.account_circle_sharp,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('Name: ${data!['name']}'),
                              Text('Name: '),
                              Text(
                                // '${user?.email}',
                                // 'Email: ${data!['email']}',
                                'Email: ',
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      // Center(
                      //   child: data != null
                      //       ? Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text('ID: ${data!['id']}'),
                      //           ],
                      //         )
                      //       : CircularProgressIndicator(),
                      // ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/my-profile');
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.cake, color: Colors.grey),
                  title: const Text('Ваши заказы', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
                  onTap: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(user: user),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Пользователь не найден.')),
                      );
                    }
                  },
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
                  tileColor: Colors.white,
                ),
                CustomDevider(),
                ListTile(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))),
                  leading: const Icon(Icons.payment, color: Colors.grey),
                  title: const Text('Платежная система', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
                  onTap: () {},
                  tileColor: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.grey),
                  title: const Text('Язык', style: TextStyle(fontSize: 12)),
                  trailing: const Wrap(
                    spacing: 10,
                    children: [Text('Русский', style: TextStyle(fontSize: 12, color: Colors.red)), Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)],
                  ),
                  onTap: () {},
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
                  tileColor: Colors.white,
                ),
                CustomDevider(),
                ListTile(
                  leading: const Icon(Icons.location_city, color: Colors.grey),
                  title: const Text('Город', style: TextStyle(fontSize: 12)),
                  trailing: const Wrap(
                    spacing: 10,
                    children: [Text('Алматы', style: TextStyle(fontSize: 12, color: Colors.red)), Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)],
                  ),
                  onTap: () {},
                  tileColor: Colors.white,
                ),
                CustomDevider(),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.grey),
                  title: const Text('О приложений', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
                  onTap: () {},
                  tileColor: Colors.white,
                ),
                CustomDevider(),
                ListTile(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))),
                  leading: const Icon(Icons.support_agent, color: Colors.grey),
                  title: const Text('Служба поддержки', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
                  onTap: () {},
                  tileColor: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return alertClose(dialogContext);
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              maximumSize: Size(MediaQuery.of(context).size.width - 40, 50),
              minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Выйти',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
            // )
          ),
        ],
      )
    ]);

    // Text('XTHC');

    // StreamBuilder<User?>(
    //   stream: _fire.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       User? user = snapshot.data;
    //       return Column(children: [
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.only(top: 40),
    //               decoration: const BoxDecoration(color: Colors.white),
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     height: 70,
    //                     padding: const EdgeInsets.all(10),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             const Padding(
    //                               padding: EdgeInsets.only(right: 10, left: 10),
    //                               child: Icon(
    //                                 Icons.account_circle_sharp,
    //                                 color: Colors.grey,
    //                                 size: 40,
    //                               ),
    //                             ),
    //                             Column(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Text('привет ${user?.displayName}'),
    //                                 Text(
    //                                   '${user?.email}',
    //                                   style: const TextStyle(color: Colors.grey, fontSize: 12),
    //                                 ),
    //                               ],
    //                             )
    //                           ],
    //                         ),
    //                         IconButton(
    //                             onPressed: () {
    //                               Navigator.pushNamed(context, '/my-profile');
    //                             },
    //                             icon: const Icon(
    //                               Icons.edit,
    //                               color: Colors.grey,
    //                             ))
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             Container(
    //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    //               width: MediaQuery.of(context).size.width - 40,
    //               child: Column(
    //                 children: [
    //                   ListTile(
    //                     leading: const Icon(Icons.cake, color: Colors.grey),
    //                     title: const Text('Ваши заказы', style: TextStyle(fontSize: 12)),
    //                     trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
    //                     onTap: () {
    //                       final user = FirebaseAuth.instance.currentUser;
    //                       if (user != null) {
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => ViewCartDataScreen(user: user),
    //                           ),
    //                         );
    //                       } else {
    //                         ScaffoldMessenger.of(context).showSnackBar(
    //                           const SnackBar(content: Text('Пользователь не найден.')),
    //                         );
    //                       }
    //                     },
    //                     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
    //                     tileColor: Colors.white,
    //                   ),
    //                   CustomDevider(),
    //                   ListTile(
    //                     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))),
    //                     leading: const Icon(Icons.payment, color: Colors.grey),
    //                     title: const Text('Платежная система', style: TextStyle(fontSize: 12)),
    //                     trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
    //                     onTap: () {},
    //                     tileColor: Colors.white,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Container(
    //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    //               width: MediaQuery.of(context).size.width - 40,
    //               child: Column(
    //                 children: [
    //                   ListTile(
    //                     leading: const Icon(Icons.language, color: Colors.grey),
    //                     title: const Text('Язык', style: TextStyle(fontSize: 12)),
    //                     trailing: const Wrap(
    //                       spacing: 10,
    //                       children: [
    //                         Text('Русский', style: TextStyle(fontSize: 12, color: Colors.red)),
    //                         Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)
    //                       ],
    //                     ),
    //                     onTap: () {},
    //                     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
    //                     tileColor: Colors.white,
    //                   ),
    //                   CustomDevider(),
    //                   ListTile(
    //                     leading: const Icon(Icons.location_city, color: Colors.grey),
    //                     title: const Text('Город', style: TextStyle(fontSize: 12)),
    //                     trailing: const Wrap(
    //                       spacing: 10,
    //                       children: [
    //                         Text('Алматы', style: TextStyle(fontSize: 12, color: Colors.red)),
    //                         Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)
    //                       ],
    //                     ),
    //                     onTap: () {},
    //                     tileColor: Colors.white,
    //                   ),
    //                   CustomDevider(),
    //                   ListTile(
    //                     leading: const Icon(Icons.info, color: Colors.grey),
    //                     title: const Text('О приложений', style: TextStyle(fontSize: 12)),
    //                     trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
    //                     onTap: () {},
    //                     tileColor: Colors.white,
    //                   ),
    //                   CustomDevider(),
    //                   ListTile(
    //                     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))),
    //                     leading: const Icon(Icons.support_agent, color: Colors.grey),
    //                     title: const Text('Служба поддержки', style: TextStyle(fontSize: 12)),
    //                     trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
    //                     onTap: () {},
    //                     tileColor: Colors.white,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             TextButton(
    //               onPressed: () async {
    //                 showDialog(
    //                   context: context,
    //                   builder: (BuildContext dialogContext) {
    //                     return alertClose(dialogContext);
    //                   },
    //                 );
    //               },
    //               style: TextButton.styleFrom(
    //                 backgroundColor: Colors.white,
    //                 maximumSize: Size(MediaQuery.of(context).size.width - 40, 50),
    //                 minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
    //                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
    //               ),
    //               child: const Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Icon(
    //                     Icons.logout,
    //                     color: Colors.red,
    //                   ),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Text(
    //                     'Выйти',
    //                     style: TextStyle(color: Colors.red, fontSize: 16),
    //                   ),
    //                 ],
    //               ),
    //               // )
    //             ),
    //           ],
    //         )
    //       ]);
    //     } else {
    //       return const Text('awdawd', style: TextStyle(fontSize: 45),);
    //     }
    //   });
  }

  Widget alertClose(BuildContext dialogContext) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      backgroundColor: Colors.white,
      title: const Text(
        'Выйти',
        style: TextStyle(fontSize: 20),
      ),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Вы уверены?',
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: 80,
                )
              ],
            ),
            SizedBox(
              height: 1,
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Отмена',
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Выйти',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();

            await storage.delete(key: 'token');

            Navigator.of(dialogContext).pop();
            Navigator.pushReplacementNamed(context, '/profile');
          },
        ),
      ],
    );
  }

  Container CustomDevider() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: const Divider(height: 1, color: Color(0xFFB7B7B7)),
    );
  }
}
