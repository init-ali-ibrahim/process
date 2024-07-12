import 'package:flutter/material.dart';

class cake_taste_screen extends StatefulWidget {
  const cake_taste_screen({super.key});

  @override
  State<cake_taste_screen> createState() => _cake_taste_screenState();
}

class _cake_taste_screenState extends State<cake_taste_screen> {
  final List<String> _images = [
    'assets/taste/1.png',
    'assets/taste/2.png',
    'assets/taste/3.png',
    'assets/taste/4.png'
  ];

  int _currentIndex = 0;

  void _switchImage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Center(
              child: Image(image: AssetImage(_images[_currentIndex])),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: 150,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEEC3C3),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Column(
                    children: [
                      Image(image: AssetImage('assets/taste/1.png')),
                      Text('taste1')
                    ],
                  ),
                ),
                onTap: () => _switchImage(0),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                child: Container(
                  width: 150,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEEC3C3),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Column(
                    children: [
                      Image(image: AssetImage('assets/taste/2.png')),
                      Text('taste2')
                    ],
                  ),
                ),
                onTap: () => _switchImage(1),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: 150,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEEC3C3),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Column(
                    children: [
                      Image(image: AssetImage('assets/taste/3.png')),
                      Text('taste3')
                    ],
                  ),
                ),
                onTap: () => _switchImage(2),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                child: Container(
                  width: 150,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEEC3C3),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Column(
                    children: [
                      Image(image: AssetImage('assets/taste/4.png')),
                      Text('taste4')
                    ],
                  ),
                ),
                onTap: () => _switchImage(3),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
