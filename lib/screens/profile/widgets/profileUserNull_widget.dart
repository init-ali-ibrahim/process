import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        Container(
            padding: const EdgeInsets.only(top: 50),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(children: [
              Center(
                  child: Column(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 150,
                    color: Colors.grey,
                  ),
                  const Text('Войдите в аккаунт', style: TextStyle(fontSize: 16)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Center(
                        child: Text(
                          'Закажите торты, пироги и наслаждайтесь',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      )),
                ],
              )),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signUp'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  maximumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                  minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)), side: BorderSide(width: 1, color: Color(0xFFBEBEBE))),
                ),
                child: Text(
                  'Регистрация',
                  style: TextStyle(fontSize: 14, color: Colors.black87.withOpacity(0.7)),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/logIn'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  maximumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                  minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
                child: const Text(
                  'Войти',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const SizedBox(height: 30),
            ])),
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
              //     children: [Text('Русский', style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.w400)), Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)],
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
                  children: [
                    Text('Алматы', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red)),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/demo');
                },
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
                tileColor: Colors.white,
              ),
              CustomDevider(),
              ListTile(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))),
                leading: const Icon(Icons.support_agent, color: Colors.grey),
                title: const Text('Служба поддержки', style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
                onTap: () async {
                  String url = 'https://api.whatsapp.com/send?phone=77776615050&text=Hello';

                  final Uri uri = Uri.parse(url);

                  if (!await launchUrl(uri)) {
                    throw Exception('Could not launch $uri');
                  }

                  // Navigator.pushNamed(context, '/httpTest');
                },
                tileColor: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
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
