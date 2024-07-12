import 'package:flutter/material.dart';
import 'package:process/screens/cake_taste/cake_taste_screen.dart';
import 'package:process/screens/cake_fill/cake_fill_screen.dart';
import 'cake_color/cake_color_screen.dart';

class cake_create extends StatefulWidget {
  @override
  _cake_create createState() => _cake_create();
}

class _cake_create extends State<cake_create> {
  int pageIndex = 0;

  final pages = [
    const cake_fill_screen(),
    const cake_taste_screen(),
    const cake_color_screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nots'),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              '300 ₸',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 600,
                decoration: const BoxDecoration(
                    color: Color(0xFFAC89CE),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 0;
                            });
                          },
                          icon: () {
                            if (pageIndex == 0) {
                              return const Icon(
                                Icons.cabin,
                                color: Colors.white,
                                size: 25,
                              );
                            } else {
                              return const Icon(
                                Icons.cabin,
                                color: Colors.black,
                                size: 25,
                              );
                            }
                          }(),
                        ),
                        Text(
                          () {
                            if (pageIndex == 0) {
                              return 'Shape';
                            } else {
                              return 'Shape';
                            }
                          }(),
                          style: TextStyle(
                            color: pageIndex == 0 ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 1;
                            });
                          },
                          icon: () {
                            if (pageIndex == 1) {
                              return const Icon(
                                Icons.flaky,
                                color: Colors.white,
                                size: 25,
                              );
                            } else {
                              return const Icon(
                                Icons.flaky,
                                color: Colors.black,
                                size: 25,
                              );
                            }
                          }(),
                        ),
                        Text(
                          () {
                            if (pageIndex == 1) {
                              return 'Flavor';
                            } else {
                              return 'Flavor';
                            }
                          }(),
                          style: TextStyle(
                            color: pageIndex == 1 ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 2;
                            });
                          },
                          icon: () {
                            if (pageIndex == 2) {
                              return const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              );
                            } else {
                              return const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 25,
                              );
                            }
                          }(),
                        ),
                        Text(
                          () {
                            if (pageIndex == 2) {
                              return 'Color';
                            } else {
                              return 'Color';
                            }
                          }(),
                          style: TextStyle(
                            color: pageIndex == 2 ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pages[pageIndex],
            ],
          )
        ],
      ),
    );
  }
}
