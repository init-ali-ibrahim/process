import 'package:flutter/material.dart';

class home_horizontal_item_widget extends StatefulWidget {
  home_horizontal_item_widget(
      {super.key,
      required this.title,
      required this.img,
      required this.cash,
      required this.type});

  final String title;
  final String img;
  final String cash;
  final String type;

  @override
  State<home_horizontal_item_widget> createState() =>
      _home_horizontal_item_widgetState();
}

class _home_horizontal_item_widgetState
    extends State<home_horizontal_item_widget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/cake_create');
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        // margin: const EdgeInsets.only(left: 0, top: 5),
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        // decoration: BoxDecoration(
        //     border: Border.all(width: 2.0, color: Colors.green),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.red,
        //           offset: Offset(1, 1),
        //           spreadRadius: 1,
        //           blurRadius: 1)
        //     ]
        // ),
        width: 160,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  // margin: const EdgeInsets.only(top: 0),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD0BFE8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 8,
                          offset: Offset(1, 0),
                          spreadRadius: 1,
                          color: Color(0xFFE3E3E3))
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 15,
                  right: 15,
                  child: Image(image: AssetImage(widget.img)),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 8,
                        // offset: Offset(0, 0),
                        offset: Offset(1, 0),
                        spreadRadius: 1,
                        color: Color(0xFFE3E3E3))
                  ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4))),
              padding: const EdgeInsets.only(
                  right: 10, top: 10, left: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.type,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.cash} ₸',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF953282)),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFF953282),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
