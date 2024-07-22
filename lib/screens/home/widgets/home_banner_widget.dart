import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

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
        const snackBar = SnackBar(
          content: Text('Кнопка нажата (MainBanner)'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        margin: const EdgeInsetsDirectional.all(14),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF5D5EB),
          borderRadius: BorderRadius.circular(10),
          // boxShadow: const [
          //   BoxShadow(
          //       blurRadius: 0.8,
          //       spreadRadius: 0.1,
          //       offset: Offset(0.1, 0.8),
          //       color: Color(0xFFBBBBBB))
          // ]),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 1,
                color: Color(0xFFC9C9C9))
          ],
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
                    color: Color(0xFFA02F7F),
                  ),
                )),
            Positioned(
                top: -35,
                right: 10,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFA02F7F)),
                )),
            Positioned(
                bottom: 5,
                right: 8,
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF3C0E0), shape: BoxShape.circle),
                    child: const InkWell(
                        child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Color(0xFFA02F7F),
                    ))
                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.arrow_forward,
                    //     size: 16,
                    //     color: Color(0xFFA02F7F),
                    //   ),
                    //   // padding: const EdgeInsets.all(10),
                    //   style: const ButtonStyle(),
                    //   // onPressed: () {},
                    //
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/CounterScreen');
                    //     // Navigator.pushNamed(context, '/cake_create');
                    //     // /CounterScreen
                    //
                    //   },
                    // ),
                    )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 12),
                // Icon(Icons.account_balance_outlined, size: 60),

                GifView.asset(
                  'assets/cake.gif',
                  // height: 200,
                  width: 60,
                ),

                const SizedBox(width: 12),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Make your own cake!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      'No one can do it better than you',
                      style: TextStyle(
                          color: Color(0xFF953282),
                          fontWeight: FontWeight.w500),
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
