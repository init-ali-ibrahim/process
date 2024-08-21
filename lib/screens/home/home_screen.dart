import "package:flutter/material.dart";
import 'package:process/screens/color.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/screens/home/widgets/home_banner_widget.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String countCity = 'Алматы';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              pinned: true,
              snap: true,
              floating: true,
              surfaceTintColor: Colors.transparent,
              shadowColor: const Color(0xFFF5F5F5),
              title: SafeArea(
                  child: Row(
                children: [
                  Image.asset('assets/image/logo.png', width: 90),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Доставка в',
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
              )),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(58.0),
                  child: SafeArea(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F0F0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Color(0xFF313131),
                            ),
                            onPressed: () {
                              widget;
                            },
                          ),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Пойск',
                                border: InputBorder.none,
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                hintStyle: TextStyle(fontSize: 14, color: Color(0xFF313131), fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                const HomeBannerWidget(),
                HomeHorizontalItemTitleWidget(
                  title: 'Пироги',
                  icon: Icons.access_time_filled,
                ),
                SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      HomeHorizontalItemWidget(
                          title: 'Баноффи',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2Fapricot.jpg?alt=media&token=fd2b535e-ad74-4f96-a16c-cf555151f55e',
                          type: 'Состав: Мука пшеничная в/c, разрыхлитель сахар, маргарин. желток, вареная сгущенка, банан, какао, сливки, творжный сыр, сахарная пудра'),
                      HomeHorizontalItemWidget(
                          title: 'Абрикосовый',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F4%20(1).jpg?alt=media&token=a4c6ed79-f175-45de-ab25-05004df35b72',
                          type: 'Состав: Мука пшеничная в/c, разрыхлитель, сахар, маргарин, яйцо, сметана, белая сгущенка, абрикос, сливки'),
                      HomeHorizontalItemWidget(
                          title: 'Восточный',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F3%20(1).jpg?alt=media&token=8be3b3c6-f787-48ce-915b-8dc5d05ee09a',
                          type: 'Состав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, грец.орех, изюм, курага, белая сгущенка'),
                      HomeHorizontalItemWidget(
                          title: 'Йогуртовый',
                          cash: '2 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F2%20(1).jpg?alt=media&token=630e3028-3f20-41f7-998e-ab93575b4003',
                          type: 'Cостав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, сметана, белая сгущенка, йогурт, растительное масло, персик'),
                      HomeHorizontalItemWidget(
                          title: 'Карамельный',
                          cash: '3 200',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F1%20(1).jpg?alt=media&token=9d3f3222-7bed-44a3-9d48-c6020d351f7c',
                          type: 'Состав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, сметана, варенная сгущенка, ванилин'),
                    ],
                  ),
                ),
                HomeHorizontalItemTitleWidget(
                  title: 'Шоколадные',
                  icon: Icons.ac_unit_rounded,
                ),
                SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      HomeHorizontalItemWidget(
                          title: 'Йогуртовый',
                          cash: '2 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F2%20(1).jpg?alt=media&token=630e3028-3f20-41f7-998e-ab93575b4003',
                          type: 'Cостав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, сметана, белая сгущенка, йогурт, растительное масло, персик'),
                      HomeHorizontalItemWidget(
                          title: 'Карамельный',
                          cash: '3 200',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F1%20(1).jpg?alt=media&token=9d3f3222-7bed-44a3-9d48-c6020d351f7c',
                          type: 'Состав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, сметана, варенная сгущенка, ванилин'),
                      HomeHorizontalItemWidget(
                          title: 'Баноффи',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2Fapricot.jpg?alt=media&token=fd2b535e-ad74-4f96-a16c-cf555151f55e',
                          type: 'Состав: Мука пшеничная в/c, разрыхлитель сахар, маргарин. желток, вареная сгущенка, банан, какао, сливки, творжный сыр, сахарная пудра'),
                      HomeHorizontalItemWidget(
                          title: 'Абрикосовый',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F4%20(1).jpg?alt=media&token=a4c6ed79-f175-45de-ab25-05004df35b72',
                          type: 'Состав: Мука пшеничная в/c, разрыхлитель, сахар, маргарин, яйцо, сметана, белая сгущенка, абрикос, сливки'),
                      HomeHorizontalItemWidget(
                          title: 'Восточный',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F3%20(1).jpg?alt=media&token=8be3b3c6-f787-48ce-915b-8dc5d05ee09a',
                          type: 'Состав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, грец.орех, изюм, курага, белая сгущенка'),
                    ],
                  ),
                ),
                HomeHorizontalItemTitleWidget(
                  title: 'Ванильные',
                  icon: Icons.account_balance_wallet_sharp,
                ),
                SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      HomeHorizontalItemWidget(
                          title: 'Йогуртовый',
                          cash: '2 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F2%20(1).jpg?alt=media&token=630e3028-3f20-41f7-998e-ab93575b4003',
                          type: 'Cостав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, сметана, белая сгущенка, йогурт, растительное масло, персик'),
                      HomeHorizontalItemWidget(
                          title: 'Карамельный',
                          cash: '3 200',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F1%20(1).jpg?alt=media&token=9d3f3222-7bed-44a3-9d48-c6020d351f7c',
                          type: 'Состав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, сметана, варенная сгущенка, ванилин'),
                      HomeHorizontalItemWidget(
                          title: 'Баноффи',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2Fapricot.jpg?alt=media&token=fd2b535e-ad74-4f96-a16c-cf555151f55e',
                          type: 'Состав: Мука пшеничная в/c, разрыхлитель сахар, маргарин. желток, вареная сгущенка, банан, какао, сливки, творжный сыр, сахарная пудра'),
                      HomeHorizontalItemWidget(
                          title: 'Абрикосовый',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F4%20(1).jpg?alt=media&token=a4c6ed79-f175-45de-ab25-05004df35b72',
                          type: 'Состав: Мука пшеничная в/c, разрыхлитель, сахар, маргарин, яйцо, сметана, белая сгущенка, абрикос, сливки'),
                      HomeHorizontalItemWidget(
                          title: 'Восточный',
                          cash: '3 500',
                          img:
                              'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2F3%20(1).jpg?alt=media&token=8be3b3c6-f787-48ce-915b-8dc5d05ee09a',
                          type: 'Состав: Мука пшеничная в/с, разрыхлитель, сахар, маргарин, яйцо, грец.орех, изюм, курага, белая сгущенка'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ))
          ],
        ));
  }

  showAppbarCountry(BuildContext context) async {
    final cityName = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          height: 500,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Выберите город доставки',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  _buildCityOption(context, 'Алматы', 'assets/image/almaty-logo.png'),
                  _buildCityOption(context, 'Астана', 'assets/image/astana-logo.png'),
                  _buildCityOption(context, 'Уральск', 'assets/image/uralsk-logo.png'),
                  _buildCityOption(context, 'Актобе', 'assets/image/aktobe-logo.png'),
                ],
              ),
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

  Widget _buildCityOption(BuildContext context, String cityName, String assetPath) {
    final isSelected = countCity == cityName;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.pop(context, cityName);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE3D8D8) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 80,
          child: Column(
            children: [
              Image(
                image: AssetImage(assetPath),
                width: 50,
              ),
              Text(
                cityName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? colorDark : Colors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
