import 'package:flutter/material.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xffff8d58),
              Color(0xffed7558),
              Color(0xffd85f57),
              Color(0xffc14a55),
              Color(0xffd23f4b),
              Color(0xffd22b2e),
              Color(0xffb42023),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
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
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cake_create');
                    },
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
              margin: const EdgeInsets.only(top: 10, right: 20),
              child: Image.asset(
                'assets/image/main_screen/cake.png',
                height: 90,
                width: 90,
              ),
            )
          ],
        ),
      ),
    );
  }
}
