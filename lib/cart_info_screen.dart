import 'package:flutter/material.dart';
import 'package:process/cart_info_widget.dart';

class cart_info_screen extends StatefulWidget {
  const cart_info_screen({super.key});

  @override
  State<cart_info_screen> createState() => _cart_info_screenState();
}

class _cart_info_screenState extends State<cart_info_screen> {
  int quantity = 1;
  int price = 15;

  List<String> cartItems = [];

  void addToCart(String item) {
    setState(() {
      cartItems.add(item);
    });
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    int totalPrice = quantity * price;

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
            child: Column(
              children: [
                Container(
                  height: 90,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFFDADADA))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(image: AssetImage('assets/1.png')),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Mini Standart',
                                      style: TextStyle(fontSize: 16)),
                                  Text(
                                    'Choko Chush',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF212121)),
                                  ),
                                ],
                              ),
                              Text('$totalPrice',
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0xFF212121)))
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(''),
                          Row(
                            children: [
                              InkWell(
                                child: Icon(
                                    quantity > 1 ? Icons.remove : Icons.delete),
                                onTap: () {
                                  setState(() {
                                    if (quantity > 0) {
                                      quantity--;
                                    }
                                  });
                                },
                              ),
                              const SizedBox(width: 5),
                              Text('$quantity'),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (quantity < 30) {
                                      quantity++;
                                    }
                                  });
                                },
                                child: const Icon(Icons.add),
                              )
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
                Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Addons',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () => widget, child: const Text('See all'))
                    ],
                  ),
                ),
                Container(
                  height: 185,
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
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                // const SizedBox(height: 40),
                // Container(
                //   margin: const EdgeInsets.only(right: 10, left: 10),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Card message',
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 20),
                //       ),
                //       const SizedBox(height: 8),
                //       Container(
                //         // width: MediaQuery.of(context).size.width - 10,
                //         // margin: EdgeInsets.only(),
                //         padding: const EdgeInsets.only(
                //             right: 10, left: 10, top: 8, bottom: 8),
                //         decoration: const BoxDecoration(
                //           borderRadius: BorderRadius.all(Radius.circular(8)),
                //           color: Color(0xFFE0D1BB),
                //         ),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             SizedBox(
                //               width: MediaQuery.of(context).size.width - 200,
                //               child: const Text(
                //                   'There`s no card message included with your order'),
                //             ),
                //             TextButton(
                //                 onPressed: () => widget,
                //                 child: const Text(
                //                   'Add card message',
                //                   style: TextStyle(color: Color(0xFF953282)),
                //                 ))
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recipient',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: const Color(0xFFFFFFFF),
                            border:
                                Border.all(width: 1, color: Color(0xFFDADADA))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            )),
                            InkWell(
                              onTap: () async {
                                showRecipient(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    bottom: 8, top: 8, left: 10, right: 10),
                                child: const Row(
                                  children: [
                                    Icon(Icons.add, color: Color(0xFF953282)),
                                    SizedBox(width: 20),
                                    Text(
                                      'Add recipient details',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFDEDEDE),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      padding: const EdgeInsets.only(
                          right: 12, top: 5, bottom: 5, left: 18),
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
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: const ExpansionTile(
                        backgroundColor: Color(0xFFDEDEDE),
                        collapsedBackgroundColor: Color(0xFFDEDEDE),
                        iconColor: Colors.black,
                        leading: Icon(Icons.add),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        title: Text('Leave a note for Lola'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                                hintText:
                                    'Example: write the message on the cake',
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            // top: 0,
            left: 0,
            child: Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 1, color: Color(0xFFDADADA)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total (excl. shipping)'),
                      Text(
                        'BHD 15.8',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () => widget,
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        backgroundColor: const Color(0xFF953282)),
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showRecipient(BuildContext context) async {
    final cityName = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Text('data'),
        );
      },
    );
  }
}
