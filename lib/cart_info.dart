import 'package:flutter/material.dart';
import 'package:process/cart_info_widget.dart';

import 'screens/home/widgets/home_horizontal_item_widget.dart';

class cart_info extends StatefulWidget {
  const cart_info({super.key});

  @override
  State<cart_info> createState() => _cart_infoState();
}

class _cart_infoState extends State<cart_info> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child:
              Column(
                children: [
                  Container(
                    height: 90,
                    padding: const EdgeInsets.all(10),
                    // margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(
                            width: 1, color: const Color(0xFFB2B2B2))),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(image: AssetImage('assets/1.png')),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Mini Standart',
                                        style: TextStyle(fontSize: 16)),
                                    Text(
                                      'Choko Chush',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF212121)),
                                    ),
                                  ],
                                ),
                                Text('BHD 15.800',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF212121)))
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(width: 5),
                                Text("1"),
                                SizedBox(width: 5),
                                Icon(Icons.add)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Addons',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () => widget, child: const Text('See all'))
                    ],
                  ),
                  Container(
                    height: 181,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        cart_info_widget(
                          title: 'Cake 9',
                          cash: '300',
                          img: 'assets/1.png',
                        ),
                        cart_info_widget(
                          title: 'Cake 8',
                          cash: '299',
                          img: 'assets/2.png',
                        ),
                        cart_info_widget(
                          title: 'Cake 7',
                          cash: '400',
                          img: 'assets/3.png',
                        ),
                        cart_info_widget(
                          title: 'Cake 7',
                          cash: '400',
                          img: 'assets/3.png',
                        ),
                        cart_info_widget(
                          title: 'Cake 7',
                          cash: '400',
                          img: 'assets/3.png',
                        ),
                        cart_info_widget(
                          title: 'Cake 7',
                          cash: '400',
                          img: 'assets/3.png',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Card message',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width - 10,
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, top: 8, bottom: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xFFE0D1BB),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 200,
                              child: const Text(
                                  'There`s no card message included with your order'),
                            ),
                            TextButton(
                                onPressed: () => widget,
                                child: const Text(
                                  'Add card message',
                                  style: TextStyle(color: Color(0xFF953282)),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recipient',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: const Color(0xFFFFFFFF),
                            border: Border.all(width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              color: Colors.red,
                            )),
                            Container(
                              padding: const EdgeInsets.only(
                                  bottom: 8, top: 8, left: 10, right: 10),
                              child: const Row(
                                children: [
                                  Icon(Icons.add, color: Color(0xFF953282)),
                                  SizedBox(width: 20),
                                  Text(
                                    'Add recipient details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFDEDEDE),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.only(right: 8, left: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Keep my identity secret',
                          style: TextStyle(fontSize: 16),
                        ),
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          fillColor: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> states) {
                            if (!states.contains(MaterialState.selected)) {
                              return Colors.white;
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  ExpansionTile(
                    title: Text('ExpansionTile 1'),
                    subtitle: Text('Trailing expansion arrow icon'),
                    children: <Widget>[
                      ListTile(title: Text('This is tile number 1')),
                    ],
                  ),


                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFDEDEDE),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.only(
                        right: 20, left: 12, top: 12, bottom: 12),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.messenger_outline),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Leave a note for Lola',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined),
                      ],
                    ),
                  ),

                SizedBox(height: 200,)
                ],
              ),
          ),
          // Positioned(
          //   bottom: 60,
          //   right: 0,
          //   // top: 0,
          //   left: 0,
          //   child: Container(
          //     height: 55,
          //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //     decoration: const BoxDecoration(
          //         color: Colors.white,
          //         border: Border.symmetric(horizontal: BorderSide(width: 1))),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         const Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text('Total (excl. shipping'),
          //             Text(
          //               'BHD 15.8',
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             )
          //           ],
          //         ),
          //         TextButton(
          //           onPressed: () => widget,
          //           style: TextButton.styleFrom(
          //             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
          //             backgroundColor: Color(0xFF953282)
          //           ),
          //           child: const Text('Continue', style: TextStyle(color: Colors.white),),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}