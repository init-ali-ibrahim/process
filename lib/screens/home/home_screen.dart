import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process/screens/home/bloc/home_bloc.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_widget.dart';
import 'package:process/screens/home/widgets/home_banner_widget.dart';
import 'package:process/screens/home/widgets/show_appbar_country.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  final _homeChangeCityEvent = HomeBloc();

  // _homeChangeCityEvent.add(homeChangeCityEvent)

  @override
  void initState() {
    // TODO: implement initState
    _homeChangeCityEvent.add(homeChangeCityEvent());
    super.initState();
  }


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
                const Icon(Icons.co_present),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => show_appbar_country(context),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Text(
                      'Riyadh',
                      style: TextStyle(fontSize: 18, color: Color(0xFF953282)),
                    )
                  ),
                const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Color(0xFF953282),
                ),
              ],
            )
          ],
        ),
        leading: const Icon(Icons.account_tree_sharp),
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
            title: 'Birthday Collection',
            icon: Icons.access_time_filled,
          ),
          Container(
            height: 190,
            decoration: const BoxDecoration(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                home_horizontal_item_widget(
                    title: 'Cake 9',
                    cash: '300',
                    img: 'assets/1.png',
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
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          home_horizontal_item_title_widget(
            title: 'Football Collection',
            icon: Icons.ac_unit_rounded,
          ),
          Container(
            height: 190,
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
                const SizedBox(
                  width: 20,
                  height: 400,
                )
              ],
            ),
          ),
          home_horizontal_item_title_widget(
            title: 'Cartoon Collection',
            icon: Icons.abc_sharp,
          ),
          Container(
            height: 190,
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
                const SizedBox(
                  width: 20,
                  height: 400,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),

          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(homeChangeCityEvent());
            },
            child: Text('Загрузить магазин'),
          ),
        ],
      )),
    );
  }
}


Future<void> show_appbar_country(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18))),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'To where your next cake?',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),
            Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.ac_unit_rounded,
                            size: 40,
                          ),
                          Text('Алматы')
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.ac_unit_rounded,
                            size: 40,
                          ),
                          Text('Астана')
                        ],
                      ),
                    ),


                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.ac_unit_rounded,
                            size: 40,
                          ),
                          Text('Шымкент')
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      );
    },
  );
}
