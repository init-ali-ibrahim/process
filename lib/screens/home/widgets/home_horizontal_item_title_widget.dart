import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(right: 20, top: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(children: [
              Icon(
                widget.icon,
                // Icons.access_time_filled,
                size: 24,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ]),
          ),
          TextButton(onPressed: () => Navigator.pushNamed(context, '/see_all_item'), child: const Text('See all'))
        ],
      ),
    );
  }
}
