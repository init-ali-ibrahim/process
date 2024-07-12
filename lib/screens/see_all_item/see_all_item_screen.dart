import 'package:flutter/material.dart';
import 'package:process/screens/see_all_item/widgets/see_all_item_widget.dart';

class see_all_item extends StatefulWidget {
  const see_all_item({super.key});

  @override
  State<see_all_item> createState() => _see_all_itemState();
}

class _see_all_itemState extends State<see_all_item> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.add_business_rounded),
            SizedBox(width: 10),
            Text('Fast Delivery', textAlign: TextAlign.center),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          children: [
            see_all_item_widget(
                title: 'Mini',
                type: 'Vanilla',
                cash: '23',
                img: 'assets/1.png',
            ),
            see_all_item_widget(
              title: 'Mini',
              type: 'Vanilla',
              cash: '23',
              img: 'assets/1.png',
            ),
            see_all_item_widget(
              title: 'Mini',
              type: 'Vanilla',
              cash: '23',
              img: 'assets/1.png',
            ),
            see_all_item_widget(
              title: 'Mini',
              type: 'Vanilla',
              cash: '23',
              img: 'assets/1.png',
            ),
            see_all_item_widget(
              title: 'Mini',
              type: 'Vanilla',
              cash: '23',
              img: 'assets/4.png',
            ),
            see_all_item_widget(
              title: 'Mini',
              type: 'Vanilla',
              cash: '23',
              img: 'assets/2.png',
            ),
            see_all_item_widget(
              title: 'Mini',
              type: 'Vanilla',
              cash: '23',
              img: 'assets/3.png',
            ),
          ],
        ),
      ),
    );
  }
}
