import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/screens/order/order_screen.dart';
import 'package:http/http.dart' as http;

class profileUserAuth_widget extends StatefulWidget {
  const profileUserAuth_widget({super.key});

  @override
  State<profileUserAuth_widget> createState() => _profileUserAuth_widgetState();
}

class _profileUserAuth_widgetState extends State<profileUserAuth_widget> {
  final storage = const FlutterSecureStorage();
  Map<String, dynamic>? data;

  Future<void> checkAuthToken() async {
    String? tokenAuth = await storage.read(key: 'token');

    final url = Uri.parse('http://192.168.0.219:80/api/v1/auth/check');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $tokenAuth',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      setState(() {
        this.data = data?['data'];
      });

      // print(tokenAuth);
      // print('Success: ${data['success']}');
      // print('User ID: ${data['data']['id']}');
      // print('Name: ${data['data']['name']}');
    } else {
      await storage.delete(key: 'token');
      Navigator.pushNamedAndRemoveUntil(context, '/profile', (Route<dynamic> route) => false);

      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    checkAuthToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return SizedBox();
    }

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
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
                              Text('${data!['name'] ?? ''}'),
                              Text(
                                '${data!['email'] ?? ''}',
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, '/my-profile');
                      //     },
                      //     icon: const Icon(
                      //       Icons.edit,
                      //       color: Colors.grey,
                      //     ))
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(),
                      ),
                    );
                  },
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                  tileColor: Colors.white,
                ),
                // CustomDevider(),
                // ListTile(
                //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))),
                //   leading: const Icon(Icons.payment, color: Colors.grey),
                //   title: const Text('Платежная система', style: TextStyle(fontSize: 12)),
                //   trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
                //   onTap: () {},
                //   tileColor: Colors.white,
                // ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              children: [
                // ListTile(
                //   leading: const Icon(Icons.language, color: Colors.grey),
                //   title: const Text('Язык', style: TextStyle(fontSize: 12)),
                //   trailing: const Wrap(
                //     spacing: 10,
                //     children: [Text('Русский', style: TextStyle(fontSize: 12, color: Colors.red)), Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)],
                //   ),
                //   onTap: () {},
                //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
                //   tileColor: Colors.white,
                // ),
                // CustomDevider(),
                ListTile(
                  leading: const Icon(Icons.location_city, color: Colors.grey),
                  title: const Text('Город', style: TextStyle(fontSize: 12)),
                  trailing: const Wrap(
                    spacing: 10,
                    children: [Text('Алматы', style: TextStyle(fontSize: 12, color: Colors.red)), Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/demo');
                  },
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
                  tileColor: Colors.white,
                ),
                // CustomDevider(),
                // ListTile(
                //   leading: const Icon(Icons.info, color: Colors.grey),
                //   title: const Text('О приложений', style: TextStyle(fontSize: 12)),
                //   trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
                //   onTap: () {},
                //   tileColor: Colors.white,
                // ),
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

  CustomDevider() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: const Divider(height: 1, color: Color(0xFFB7B7B7)),
    );
  }
}
