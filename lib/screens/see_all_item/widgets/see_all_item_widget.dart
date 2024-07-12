import 'package:flutter/material.dart';

class see_all_item_widget extends StatefulWidget {
  see_all_item_widget(
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
  State<see_all_item_widget> createState() =>
      _see_all_item_widgetState();
}

class _see_all_item_widgetState
    extends State<see_all_item_widget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/water');
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        height: 200,
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD0BFE8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            offset: Offset(1, 1),
                            spreadRadius: 0,
                            color: Colors.grey)
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: -10,
                    child: Image(image: AssetImage(widget.img)),
                  ),
                ],
              ),
            ),
            Container(
              width: 180,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.2,
                        offset: Offset(0.2, 0.1),
                        spreadRadius: 0,
                        color: Colors.grey)
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
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.type,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cash,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF953282)),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFF953282),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4))),
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
