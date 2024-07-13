import 'package:flutter/material.dart';
import 'package:process/cart_info_screen.dart';
import 'package:process/screens/profile/profile_screen.dart';
import 'package:process/screens/home/home_screen.dart';
import 'package:process/screens/cart/cart_screen.dart';
import 'package:process/testJson.dart';



class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  _navbar createState() => _navbar();
}

class _navbar extends State<navbar> {
  int pageIndex = 0;

  final pages = [
    const home_screen(),
    const cart_screen(),
    const testJson(),
    const cart_info_screen(),
    const profile_screen(),
  ];

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
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 5),
                      child: Column(
                        children: [
                          () {
                            if (pageIndex == 0) {
                              return const Icon(
                                Icons.home_outlined,
                                color: Color(0xFF731957),
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
                              color: pageIndex == 0
                                  ? const Color(0xFF731957)
                                  : Colors.black54,
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
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 5),
                      child: Column(
                        children: [
                          () {
                            if (pageIndex == 1) {
                              return const Icon(
                                Icons.shopping_basket_outlined,
                                color: Color(0xFF731957),
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
                              color: pageIndex == 1
                                  ? const Color(0xFF731957)
                                  : Colors.black54,
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
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 5),
                      child: Column(
                        children: [
                          () {
                            if (pageIndex == 2) {
                              return const Icon(
                                Icons.person_2_outlined,
                                color: Color(0xFF731957),
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
                              color: pageIndex == 2
                                  ? const Color(0xFF731957)
                                  : Colors.black54,
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
