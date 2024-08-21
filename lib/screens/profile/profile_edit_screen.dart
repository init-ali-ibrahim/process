import 'package:flutter/material.dart';
import 'package:process/screens/color.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String name = '';
  String surname = '';
  String email = '';
  String dateOfBirth = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const Icon(
                    Icons.account_circle_sharp,
                    size: 90,
                    color: Colors.grey,
                  ),
                  Positioned(
                      right: 5,
                      bottom: 5,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle, border: Border.all(width: 2, color: Colors.white)),
                        child: const Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Имя',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Фамилия',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        surname = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Почта',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/logIn'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      maximumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                      minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize:   Size(MediaQuery.of(context).size.width - 20, 50),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    child: const Text(
                      'Удалить аккаунт',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
