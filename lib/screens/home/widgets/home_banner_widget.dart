import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:process/color.dart';

class home_banner_widget extends StatefulWidget {
  const home_banner_widget({super.key});

  @override
  State<home_banner_widget> createState() => _home_banner_widgetState();
}

class _home_banner_widgetState extends State<home_banner_widget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.pushNamed(context, '/cake_create');
      },
      child: Container(
        margin: const EdgeInsetsDirectional.all(14),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF5D5D5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(blurRadius: 2, offset: Offset(0, 0), spreadRadius: 1, color: Color(0xFFC9C9C9))],
        ),
        child: Stack(
          children: [
            Positioned(
                top: 10,
                left: -20,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorDark,
                  ),
                )),
            Positioned(
                top: -35,
                right: 10,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: colorDark),
                )),
            Positioned(
                bottom: 5,
                right: 8,
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(color: Color(0xFFF3C0C0), shape: BoxShape.circle),
                    child: const InkWell(
                        child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: colorDark,
                    )))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 12),
                GifView.asset(
                  'assets/cake.gif',
                  width: 60,
                ),
                const SizedBox(width: 12),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Можно сделать свой cake!',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black87),
                    ),
                    Text(
                      'Никто не может это сделать лучше вас',
                      style: TextStyle(color: Color(0xFF953232), fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
