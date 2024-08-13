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
      child:  Container(
        margin: const EdgeInsetsDirectional.all(14),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff5b093e),
              Color(0xff751746),
              Color(0xff8f274d),
              Color(0xffa93752),
              Color(0xffc14a55),
              Color(0xffd85f57),
              Color(0xffed7558),
              Color(0xffff8d58),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              // width: 300,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Никто не может это сделать лучше вас',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const Text(
                    'Можно сделать свой торт!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18, letterSpacing: -0.2),
                  ),
                  SizedBox(height: 6),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.2), padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5)),
                    child: const Text(
                      'Сделать сейчас',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child:
              Image.asset(
                'assets/main_screen/cake.png',
                height: 90,
                width: 90,
              ),
            )
          ],
        ),
      ),


      // Container(
      //   margin: const EdgeInsetsDirectional.all(14),
      //   width: MediaQuery.of(context).size.width,
      //   height: 100,
      //   decoration: BoxDecoration(
      //     color: const Color(0xFFF5D5D5),
      //     borderRadius: BorderRadius.circular(10),
      //     boxShadow: const [BoxShadow(blurRadius: 2, offset: Offset(0, 0), spreadRadius: 1, color: Color(0xFFC9C9C9))],
      //   ),
      //   child: Stack(
      //     children: [
      //       Positioned(
      //           top: 10,
      //           left: -20,
      //           child: Container(
      //             height: 60,
      //             width: 60,
      //             decoration: const BoxDecoration(
      //               shape: BoxShape.circle,
      //               color: colorDark,
      //             ),
      //           )),
      //       Positioned(
      //           top: -35,
      //           right: 10,
      //           child: Container(
      //             height: 60,
      //             width: 60,
      //             decoration: const BoxDecoration(shape: BoxShape.circle, color: colorDark),
      //           )),
      //       Positioned(
      //           bottom: 5,
      //           right: 8,
      //           child: Container(
      //               width: 30,
      //               height: 30,
      //               decoration: const BoxDecoration(color: Color(0xFFF3C0C0), shape: BoxShape.circle),
      //               child: const InkWell(
      //                   child: Icon(
      //                 Icons.arrow_forward,
      //                 size: 16,
      //                 color: colorDark,
      //               )))),
      //       Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           const SizedBox(width: 12),
      //           GifView.asset(
      //             'assets/cake.gif',
      //             width: 60,
      //           ),
      //           const SizedBox(width: 12),
      //           const Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               SizedBox(height: 20),
      //               Text(
      //                 'Можно сделать свой торт!',
      //                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black87),
      //               ),
      //               Text(
      //                 'Никто не может это сделать лучше вас',
      //                 style: TextStyle(color: Color(0xFF953232), fontSize: 12, fontWeight: FontWeight.w500),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),


    );
  }
}
