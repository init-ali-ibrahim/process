import 'package:flutter/material.dart';
import 'package:process/color.dart';

class profileEdit extends StatefulWidget {
  const profileEdit({super.key});

  @override
  State<profileEdit> createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {
  final _formKey = GlobalKey<FormState>();
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
              // child: Form(
              //   key: _formKey,
              child: Column(
                children: [
                  // Center(
                  //   child: Stack(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 40,
                  //         backgroundColor: Colors.black,
                  //         child: IconButton(
                  //           icon: const Icon(Icons.camera_alt, color: Colors.white),
                  //           onPressed: () {
                  //             // Handle change profile picture
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ИМЯ',
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
                      labelText: 'ФАМИЛИЯ',
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
                      labelText: 'ПОЧТА',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ДАТА РОЖДЕНИЕ',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    initialValue: '2024-08-06',
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateOfBirth = pickedDate.toString().split(' ')[0];
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('ПОЛ'),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Male'),
                          leading: Radio<String>(
                            value: 'Мужской',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Female'),
                          leading: Radio<String>(
                            value: 'Женский',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: colorLight,
                      minimumSize: Size(MediaQuery.of(context).size.width - 20, 50),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    child: const Text(
                      'Сохранить ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: (){ },
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width - 20, 50),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    child: const Text(
                      'Удалить аккаунт',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
