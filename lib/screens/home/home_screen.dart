import "package:flutter/material.dart";
import 'package:process/color.dart';
import 'package:process/screens/cake_template.dart';
import 'package:process/screens/home/widgets/home_customize_widget.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_widget.dart';
import 'package:process/screens/home/widgets/home_banner_widget.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  String countCity = 'Алматы';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        // backgroundColor: Color(0xFFFEE7E8),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: const Color(0xFFECECEC),
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 90),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Доставить cake',
                  style: TextStyle(fontSize: 14),
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 110,
                        child: InkWell(
                          onTap: () async {
                            showAppbarCountry(context);
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Text(
                            countCity,
                            style: const TextStyle(color: colorDark, fontSize: 20),
                          ),
                        )),
                    const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: colorDark,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),

        // leading: Padding(
        //     padding: const EdgeInsets.only(left: 10),
        //     child: Image.asset('assets/logo2.png', width: 200)),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  onPressed: () {
                    widget;
                  },
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Какой cake ищем',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const home_banner_widget(),
          home_horizontal_item_title_widget(
            title: 'Ванильные',
            icon: Icons.access_time_filled,
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                home_horizontal_item_widget(title: 'Ванильные 1', cash: '100', img: 'assets/5.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Ванильные 2', cash: '200', img: 'assets/5.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Ванильные 3', cash: '300', img: 'assets/5.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Ванильные 4', cash: '400', img: 'assets/5.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Ванильные 5', cash: '500', img: 'assets/5.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Ванильные 6', cash: '600', img: 'assets/5.png', type: 'vanill'),
              ],
            ),
          ),
          home_horizontal_item_title_widget(
            title: 'Шоколадные',
            icon: Icons.ac_unit_rounded,
          ),
          Container(
            height: 200,
            decoration: const BoxDecoration(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                home_horizontal_item_widget(title: 'Шоколадные 1', cash: '100', img: 'assets/00.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Шоколадные 2', cash: '200', img: 'assets/00.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Шоколадные 3', cash: '300', img: 'assets/00.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Шоколадные 4', cash: '400', img: 'assets/00.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Шоколадные 5', cash: '500', img: 'assets/00.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Шоколадные 6', cash: '600', img: 'assets/00.png', type: 'chokolate'),
              ],
            ),
          ),
          home_horizontal_item_title_widget(
            title: 'Нателла',
            icon: Icons.abc_sharp,
          ),
          Container(
            height: 200,
            decoration: const BoxDecoration(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                home_horizontal_item_widget(title: 'Нателла 1', cash: '100', img: 'assets/7.png', type: 'nutella'),
                home_horizontal_item_widget(title: 'Нателла 2', cash: '200', img: 'assets/7.png', type: 'nutella'),
                home_horizontal_item_widget(title: 'Нателла 3', cash: '300', img: 'assets/7.png', type: 'nutella'),
                home_horizontal_item_widget(title: 'Нателла 4', cash: '400', img: 'assets/7.png', type: 'nutella'),
                home_horizontal_item_widget(title: 'Нателла 5', cash: '500', img: 'assets/7.png', type: 'nutella'),
                home_horizontal_item_widget(title: 'Нателла 6', cash: '600', img: 'assets/7.png', type: 'nutella'),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          home_customize_widget(title: 'cake', cash: '500', img: 'assets/7.png', type: 'chokolate', colour: Colour.Yellow, flavor: Flavor.Vanilla, shape: Shape.MiniStandard,),
          const SizedBox(
            height: 40,
          ),
        ],
      )),
    );
  }

  showAppbarCountry(BuildContext context) async {
    final cityName = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Выберите город доставки',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (countCity == 'Алматы') ...[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Алматы');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: const Color(0xFFE3D8D8), borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 80,
                            child: const Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/almaty-logo.png'),
                                  width: 50,
                                ),
                                Text(
                                  'Алматы',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: colorDark, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                    ),
                  ] else ...[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Алматы');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: 80,
                            child: const Column(
                              children: [
                                Image(image: AssetImage('assets/almaty-logo.png'), width: 50),
                                Text(
                                  'Алматы',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                  if (countCity == 'Астана') ...[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Астана');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: const Color(0xFFE3D8D8), borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 80,
                            child: const Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/astana-logo.png'),
                                  width: 50,
                                ),
                                Text(
                                  'Астана',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: colorDark, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                    ),
                  ] else ...[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Астана');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Container(
                          width: 80,
                          child: const Column(
                            children: [
                              Image(
                                image: AssetImage('assets/astana-logo.png'),
                                width: 50,
                              ),
                              Text(
                                'Астана',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (countCity == 'Шымкент') ...[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Шымкент');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: const Color(0xFFE3D8D8), borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 80,
                            child: const Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/shymkent-logo.png'),
                                  width: 50,
                                ),
                                Text(
                                  'Шымкент',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: colorDark, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                    ),
                  ] else ...[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Шымкент');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: 80,
                            child: const Column(
                              children: [
                                Image(image: AssetImage('assets/shymkent-logo.png'), width: 50),
                                Text(
                                  'Шымкент',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ],
              )
            ],
          ),
        );
      },
    );

    if (cityName != null) {
      setState(() {
        countCity = cityName;
      });
    }
  }
}
