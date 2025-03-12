import 'package:flutter/material.dart';

class HomeHorizontalItemTitleWidget extends StatelessWidget {
  const HomeHorizontalItemTitleWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ]),
          InkWell(
              onTap: () => Navigator.pushNamed(context, '/see_all_item'),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Text(
                'Еще',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}
