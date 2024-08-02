import 'package:flutter/material.dart';
import 'package:process/color.dart';

class home_horizontal_item_title_widget extends StatefulWidget {
  home_horizontal_item_title_widget(
      {super.key, required this.title, required this.icon});

  String title;
  var icon;

  @override
  State<home_horizontal_item_title_widget> createState() =>
      _home_horizontal_item_title_widgetState();
}

class _home_horizontal_item_title_widgetState
    extends State<home_horizontal_item_title_widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 20, left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(children: [
              Icon(
                widget.icon,
                size: 22,
                color: colorDark,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                widget.title,
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
