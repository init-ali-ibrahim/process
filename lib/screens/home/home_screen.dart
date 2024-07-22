import "package:flutter/material.dart";
import 'package:process/screens/home/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_widget.dart';
import 'package:process/screens/home/widgets/home_banner_widget.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  Color colorDarkPink = const Color(0xFFA02F7F);

  String countCity = 'Алматы';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEE7F7),
        title: Column(
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
                        "${countCity}",
                        style: TextStyle(color: colorDarkPink, fontSize: 20),
                      ),
                    )),
                const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Color(0xFF953282),
                ),
              ],
            )
          ],
        ),
        leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset('assets/iconDelivery.png')),
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
                      hintStyle: TextStyle(fontSize: 14),
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
                home_horizontal_item_widget(
                    title: 'Cake 9',
                    cash: '300',
                    img: 'assets/00.png',
                    type: 'vanill'),
                home_horizontal_item_widget(
                    title: 'Cake 8',
                    cash: '299',
                    img: 'assets/ww.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 7',
                    cash: '400',
                    img: 'assets/3.png',
                    type: 'vanill'),
                home_horizontal_item_widget(
                    title: 'Cake 9',
                    cash: '300',
                    img: 'assets/00.png',
                    type: 'vanill'),
                home_horizontal_item_widget(
                    title: 'Cake 8',
                    cash: '299',
                    img: 'assets/2.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 7',
                    cash: '400',
                    img: 'assets/3.png',
                    type: 'vanill'),
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
                home_horizontal_item_widget(
                    title: 'Cake 6',
                    cash: '400',
                    img: 'assets/4.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 5',
                    cash: '200',
                    img: 'assets/5.png',
                    type: 'vanill'),
                home_horizontal_item_widget(
                    title: 'Cake 1',
                    cash: '205',
                    img: 'assets/6.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 9',
                    cash: '300',
                    img: 'assets/00.png',
                    type: 'vanill'),
                home_horizontal_item_widget(
                    title: 'Cake 8',
                    cash: '299',
                    img: 'assets/2.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 7',
                    cash: '400',
                    img: 'assets/3.png',
                    type: 'vanill'),
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
                home_horizontal_item_widget(
                    title: 'Cake 2',
                    cash: '500',
                    img: 'assets/7.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 3',
                    cash: '450',
                    img: 'assets/8.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 4',
                    cash: '350',
                    img: 'assets/9.png',
                    type: 'vanill'),
                home_horizontal_item_widget(
                    title: 'Cake 9',
                    cash: '300',
                    img: 'assets/00.png',
                    type: 'vanill'),
                home_horizontal_item_widget(
                    title: 'Cake 8',
                    cash: '299',
                    img: 'assets/2.png',
                    type: 'chokolate'),
                home_horizontal_item_widget(
                    title: 'Cake 7',
                    cash: '400',
                    img: 'assets/3.png',
                    type: 'vanill'),
              ],
            ),
          ),
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
              Text(
                'Выберите город доставки',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // InkWell(
                  //   highlightColor: Colors.transparent,
                  //   splashColor: Colors.transparent,
                  //   onTap: () {
                  //     Navigator.pop(context, 'Алматы');
                  //   },
                  //   child: Container(
                  //       padding: const EdgeInsets.all(20),
                  //       decoration: const BoxDecoration(
                  //           color: Color(0xFFEED4E5),
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(20))),
                  //       child: Container(
                  //         width: 80,
                  //         child: const Column(
                  //           children: [
                  //             Image(
                  //               image: AssetImage('assets/almaty-logo.png'),
                  //               width: 50,
                  //             ),
                  //             Text(
                  //               'Алматы',
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   color: Color(0xFFA02F7F),
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //       )),
                  // ),

                  if (countCity == 'Алматы') ...[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Алматы');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              color: Color(0xFFEED4E5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
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
                                  style: TextStyle(
                                      color: Color(0xFFA02F7F),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                    ),
                  ] else ... [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Алматы');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: 80,
                            child: const Column(
                              children: [
                                Image(
                                    image: AssetImage('assets/almaty-logo.png'),
                                    width: 50),
                                Text(
                                  'Алматы',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
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
                          decoration: const BoxDecoration(
                              color: Color(0xFFEED4E5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
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
                                      color: Color(0xFFA02F7F),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                    ),
                  ] else ... [
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
                          decoration: const BoxDecoration(
                              color: Color(0xFFEED4E5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
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
                                  style: TextStyle(
                                      color: Color(0xFFA02F7F),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                    ),
                  ] else ... [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context, 'Шымкент');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: 80,
                            child: const Column(
                              children: [
                                Image(
                                    image: AssetImage('assets/shymkent-logo.png'),
                                    width: 50),
                                Text(
                                  'Шымкент',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
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
