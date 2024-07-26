import 'package:flutter/material.dart';
import 'package:process/NotificationPage.dart';
import 'package:process/cart_info_screen.dart';
import 'package:process/screens/profile/profile_screen.dart';
import 'package:process/screens/home/home_screen.dart';
import 'package:process/screens/cart/cart_screen.dart';
import 'package:process/color.dart';

class navbar extends StatefulWidget {
  navbar({required this.initialPageIndex});

  final int initialPageIndex;

  @override
  _navbar createState() => _navbar();
}

class _navbar extends State<navbar> {
  late int pageIndex;

  final pages = [
    const home_screen(),
    cart_screen(),
    const profile_screen(),
    // CakeCustomizationScreen(),
    // ItemScreen(),
    // NotificationPage(),
    // const testJson(),
    // const cart_info_screen(),
  ];

  @override
  void initState() {
    super.initState();
    pageIndex = widget.initialPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildNavBar(context),
    );
  }

  Container buildNavBar(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        height: 55,
        margin: const EdgeInsets.only(bottom: 0),
        child: Column(
          children: [
            Container(
              color: Colors.black12,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    child: Container(
                      width: 65,
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          () {
                            if (pageIndex == 0) {
                              return const Icon(
                                Icons.home_outlined,
                                color: colorPrimary,
                                size: 25,
                              );
                            } else {
                              return const Icon(
                                Icons.home_outlined,
                                color: Colors.black54,
                                size: 25,
                              );
                            }
                          }(),
                          Text(
                            () {
                              if (pageIndex == 0) {
                                return 'Home';
                              } else {
                                return 'Home';
                              }
                            }(),
                            style: TextStyle(
                              color: pageIndex == 0 ? colorPrimary : Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    child: Container(
                      width: 65,
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          () {
                            if (pageIndex == 1) {
                              return const Icon(
                                Icons.shopping_basket_outlined,
                                color: colorPrimary,
                                size: 25,
                              );
                            } else {
                              return const Icon(
                                Icons.shopping_basket_outlined,
                                color: Colors.black54,
                                size: 25,
                              );
                            }
                          }(),
                          Text(
                            () {
                              if (pageIndex == 1) {
                                return 'Cart';
                              } else {
                                return 'Cart';
                              }
                            }(),
                            style: TextStyle(
                              color: pageIndex == 1 ? colorPrimary : Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                    child: Container(
                      width: 65,
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          () {
                            if (pageIndex == 2) {
                              return const Icon(
                                Icons.person_2_outlined,
                                color: colorPrimary,
                                size: 25,
                              );
                            } else {
                              return const Icon(
                                Icons.person_2_outlined,
                                color: Colors.black54,
                                size: 25,
                              );
                            }
                          }(),
                          Text(
                            () {
                              if (pageIndex == 1) {
                                return 'Account';
                              } else {
                                return 'Account';
                              }
                            }(),
                            style: TextStyle(
                              color: pageIndex == 2 ? colorPrimary : Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ));
  }
}
