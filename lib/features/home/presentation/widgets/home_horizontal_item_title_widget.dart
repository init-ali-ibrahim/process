import 'package:flutter/material.dart';
import 'package:process/screens/color.dart';

class HomeHorizontalItemTitleWidget extends StatelessWidget {
  const HomeHorizontalItemTitleWidget({super.key, required this.title});

  final String title;

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
              const SizedBox(
                width: 12,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ]),
          ),
          InkWell(
              onTap: () => Navigator.pushNamed(context, '/see_all_item'),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Text(
                'Посмотреть все',
                style: TextStyle(fontSize: 15, color: colorDark, fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}
