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

class CakeTemplateArguments {
  final Shape shape;
  final Flavor flavor;
  final Colour colour;

  CakeTemplateArguments({
    required this.shape,
    required this.flavor,
    required this.colour,
  });
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
                  'Deliver to Recipient in',
                  style: TextStyle(fontSize: 14),
                ),
                Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 310,
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
                      hintText: 'What accasion are you having?',
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
            title: 'Birthday Collectiown',
            icon: Icons.access_time_filled,
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                home_horizontal_item_widget(title: 'Cake 9', cash: '300', img: 'assets/00.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Cake 8', cash: '299', img: 'assets/ww.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 7', cash: '400', img: 'assets/yellow.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Cake 9', cash: '300', img: 'assets/00.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Cake 8', cash: '299', img: 'assets/blue.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 7', cash: '400', img: 'assets/yellow.png', type: 'vanill'),
              ],
            ),
          ),
          home_horizontal_item_title_widget(
            title: 'Football Collection',
            icon: Icons.ac_unit_rounded,
          ),
          Container(
            height: 200,
            decoration: const BoxDecoration(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                home_horizontal_item_widget(title: 'Cake 6', cash: '400', img: 'assets/ministandard.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 5', cash: '200', img: 'assets/5.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Cake 1', cash: '205', img: 'assets/6.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 9', cash: '300', img: 'assets/00.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Cake 8', cash: '299', img: 'assets/blue.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 7', cash: '400', img: 'assets/yellow.png', type: 'vanill'),
              ],
            ),
          ),
          home_horizontal_item_title_widget(
            title: 'Cartoon Collection',
            icon: Icons.abc_sharp,
          ),
          Container(
            height: 200,
            decoration: const BoxDecoration(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                home_horizontal_item_widget(title: 'Cake 2', cash: '500', img: 'assets/7.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 3', cash: '450', img: 'assets/8.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 4', cash: '350', img: 'assets/9.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Cake 9', cash: '300', img: 'assets/00.png', type: 'vanill'),
                home_horizontal_item_widget(title: 'Cake 8', cash: '299', img: 'assets/blue.png', type: 'chokolate'),
                home_horizontal_item_widget(title: 'Cake 7', cash: '400', img: 'assets/yellow.png', type: 'vanill'),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          home_customize_widget(title: 'sss', cash: '500', img: 'assets/7.png', type: 'chokolate', Colour: 'lxo', Flavor: 'lox', Shape: 'sa',),
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
                          decoration: BoxDecoration(color: Color(0xFFEED4D4), borderRadius: BorderRadius.circular(20)),
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
                          decoration: BoxDecoration(color: Color(0xFFEED4D4), borderRadius: BorderRadius.circular(20)),
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
                          decoration: BoxDecoration(color: Color(0xFFEED4D4), borderRadius: BorderRadius.circular(20)),
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
