import 'package:flutter/material.dart';
import 'package:process/screens/color.dart';

class HomeHorizontalItemTitleWidget extends StatelessWidget {
  HomeHorizontalItemTitleWidget(
      {super.key, required this.title, required this.icon});

  String title;
  var icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 20, left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(children: [
              // Icon(
              //   icon,
              //   size: 22,
              //   color: colorDark,
              // ),
              const SizedBox(
                width: 12,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ]),
          ),
          InkWell(
              onTap: () => Navigator.pushNamed(context, '/see_all_item'),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Text(
                'Посмотреть все',
                style: TextStyle(fontSize: 14, color: colorDark),
              ))
        ],
      ),
    );
  }
}
