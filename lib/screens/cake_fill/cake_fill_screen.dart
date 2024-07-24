import 'package:flutter/material.dart';

class cake_fill_screen extends StatefulWidget {
  const cake_fill_screen({super.key});

  @override
  State<cake_fill_screen> createState() => _cake_fill_screenState();
}

class _cake_fill_screenState extends State<cake_fill_screen> {
  final List<String> _images = [
    'assets/fill/miniheart.png',
    'assets/fill/blue.png',
    'assets/fill/yellow.png',
    'assets/fill/ministandard.png'
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
                      Image(image: AssetImage('assets/fill/miniheart.png')),
                      Text('Fill1')
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
                      Image(image: AssetImage('assets/fill/blue.png')),
                      Text('Fill2')
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
                      Image(image: AssetImage('assets/fill/yellow.png')),
                      Text('Fill3')
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
                      Image(image: AssetImage('assets/fill/ministandard.png')),
                      Text('Fill4')
                    ],
                  ),
                ),
                onTap: () => _switchImage(3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
