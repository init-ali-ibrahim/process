import 'package:flutter/material.dart';
import 'package:process/screens/color.dart';

class HomeHorizontalItemWidget extends StatefulWidget {
  HomeHorizontalItemWidget({super.key, required this.title, required this.img, required this.cash, required this.type});

  final String title;
  final String img;
  final String cash;
  final String type;

  @override
  State<HomeHorizontalItemWidget> createState() => _HomeHorizontalItemWidgetState();
}

class _HomeHorizontalItemWidgetState extends State<HomeHorizontalItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/item_info', arguments: {
          'title': widget.title,
          'img': widget.img,
          'cash': widget.cash,
          'type': widget.type,
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        width: 175,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/image/loadingItem.jpg',
                  image: widget.img,
                  width: 170,
                  height: 155,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                      width: 170,
                      height: 155,
                    );
                  }),
              // Image.network(widget.img),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.cash} ₸',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colorLight),
                      ),
                      Container(
                          decoration: BoxDecoration(color: colorLight, borderRadius: BorderRadius.circular(4)),
                          child: const Icon(
                            size: 19,
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
