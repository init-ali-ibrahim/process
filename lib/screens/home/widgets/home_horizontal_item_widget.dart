import 'package:flutter/material.dart';
import 'package:process/color.dart';

class home_horizontal_item_widget extends StatefulWidget {
  home_horizontal_item_widget({super.key, required this.title, required this.img, required this.cash, required this.type});

  final String title;
  final String img;
  final String cash;
  final String type;

  @override
  State<home_horizontal_item_widget> createState() => _home_horizontal_item_widgetState();
}

class _home_horizontal_item_widgetState extends State<home_horizontal_item_widget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/cake_create');
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        width: 160,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEDCDC),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                    boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(1, 0), spreadRadius: 1, color: Color(0xFFE3E3E3))],
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
                        offset: Offset(1, 0),
                        spreadRadius: 1,
                        color: Color(0xFFE3E3E3))
                  ],
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(4), bottomLeft: Radius.circular(4))),
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.type,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.cash} ₸',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorLight),
                      ),
                      Container(
                          decoration: BoxDecoration(color: colorLight, borderRadius: BorderRadius.circular(4)),
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
