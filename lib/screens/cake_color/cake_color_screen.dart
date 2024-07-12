import 'package:flutter/material.dart';

class cake_color_screen extends StatefulWidget {
  const cake_color_screen({super.key});

  @override
  State<cake_color_screen> createState() => _cake_color_screenState();
}

class _cake_color_screenState extends State<cake_color_screen> {
  final List<String> _fillImages = [
    'assets/fill/1.png',
    'assets/fill/2.png',
    'assets/fill/3.png',
    'assets/fill/4.png'
  ];

  final List<String> _tasteImages = [
    'assets/taste/1.png',
    'assets/taste/2.png',
    'assets/taste/3.png',
    'assets/taste/4.png',
  ];

  final List<String> _colorImages = [
    'assets/color/1.png',
    'assets/color/2.png',
    'assets/color/3.png',
    'assets/color/4.png',
  ];

  int _currentFillIndex = 0;
  int _currentTasteIndex = 0;
  int _currentColorIndex = 0;

  void _changeFillImage(int index) {
    setState(() {
      _currentFillIndex = index;
    });
  }

  void _changeColorImage(int index) {
    setState(() {
      _currentColorIndex = index;
    });
  }

  void _changeTasteImage(int index) {
    setState(() {
      _currentTasteIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                _fillImages[_currentFillIndex],
                width: 200,
                height: 200,
              ),
              Opacity(
                opacity: 0.2,
                child: Image.asset(
                  _tasteImages[_currentTasteIndex],
                  width: 200,
                  height: 200,
                ),
              ),
              Opacity(
                opacity: 0.15,
                child: Image.asset(
                  _colorImages[_currentColorIndex],
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text('Fill:'),
                  ElevatedButton(
                    onPressed: () => _changeFillImage(0),
                    child: const Text('Fill 1'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeFillImage(1),
                    child: const Text('Fill 2'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeFillImage(2),
                    child: const Text('Fill 3'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeFillImage(3),
                    child: const Text('Fill 4'),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text('Taste:'),
                  ElevatedButton(
                    onPressed: () => _changeTasteImage(0),
                    child: const Text('Taste 1'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeTasteImage(1),
                    child: const Text('Taste 2'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeTasteImage(2),
                    child: const Text('Taste 3'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeTasteImage(3),
                    child: const Text('Taste 4'),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text('Color:'),
                  ElevatedButton(
                    onPressed: () => _changeColorImage(0),
                    child: const Text('Color 1'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeColorImage(1),
                    child: const Text('Color 2'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeColorImage(2),
                    child: const Text('Color 3'),
                  ),
                  ElevatedButton(
                    onPressed: () => _changeColorImage(3),
                    child: const Text('Color 4'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
