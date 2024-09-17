import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:process/main.dart';
import 'package:process/screens/cart/bloc/cart_bloc.dart';
import 'package:process/screens/color.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/screens/home/widgets/home_banner_widget.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String countCity = 'Алматы';
  final storage = const FlutterSecureStorage();
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedCity();
  }

  Future<void> _loadSelectedCity() async {
    final slug = await storage.read(key: 'selected_city_slug');
    if (slug != null) {
      setState(() {
        countCity = _getCityNameFromSlug(slug);
      });
    }
    _fetchProducts(slug ?? 'almaty');
    _searchProducts('', slug ?? 'almaty');
  }

  Future<void> _fetchProducts(String citySlug) async {
    final url = Uri.parse('http://192.168.0.219:80/api/v1/catalog/products');
    final response = await http.get(url, headers: {'City': citySlug});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        products = data;
      });
    } else {
      print('Failed to load products ELOG');
    }
  }

  Future<void> _searchProducts(String query, String citySlug) async {
    final url = Uri.parse('http://192.168.0.219:80/api/v1/catalog/products?search=$query');
    final response = await http.get(url, headers: {'City': citySlug});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      setState(() {
        products = data;
      });
    } else {
      print('Failed to search products ELOG');
    }
  }

  String _getCityNameFromSlug(String slug) {
    switch (slug) {
      case 'almaty':
        return 'Алматы';
      case 'astana':
        return 'Астана';
      case 'uralsk':
        return 'Уральск';
      case 'aktobe':
        return 'Актобе';
      default:
        return 'Алматы';
    }
  }

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
                        InkWell(
                            onTap: () async {
                              showAppbarCountry(context);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 85,
                                  child: Text(
                                    countCity,
                                    style: const TextStyle(color: colorDark, fontSize: 20),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: colorDark,
                                ),
                              ],
                            )),
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
                          color: const Color(0xFFF6F0F0),
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
                            Expanded(
                              child: TextField(
                                onChanged: (query) {
                                  _searchProducts(query, 'almaty');
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Поиск',
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
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      // print(product['images'][0]);
                      return HomeHorizontalItemWidget(
                        title: product['name'],
                        cash: '${product['price']}',
                        img: product['images'][0],
                        // img: 'http://192.168.0.219:80/storage/9/product5front.jpg',
                        type: 'Категория: ${product['category']}',
                        product_id: product['id'],
                      );
                    },
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Выберите город доставки',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    radius: double.maxFinite,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(99)),
                      child: const Icon(Icons.close, size: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Wrap(
              //   crossAxisAlignment: WrapCrossAlignment.center,
              //   direction: Axis.horizontal,
              //   children: [
              //     _buildCityOption(context, 'Алматы', 'assets/image/almaty-logo.png'),
              //     _buildCityOption(context, 'Астана', 'assets/image/astana-logo.png'),
              //     _buildCityOption(context, 'Уральск', 'assets/image/uralsk-logo.png'),
              //     _buildCityOption(context, 'Актобе', 'assets/image/aktobe-logo.png'),
              //   ],
              // ),
              SizedBox(
                height: 300,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  padding: const EdgeInsets.all(10),
                  children: [
                    _buildCityOption(context, 'Алматы', 'assets/image/almaty-logo.png'),
                    _buildCityOption(context, 'Астана', 'assets/image/astana-logo.png'),
                    _buildCityOption(context, 'Уральск', 'assets/image/uralsk-logo.png'),
                    _buildCityOption(context, 'Актобе', 'assets/image/aktobe-logo.png'),
                  ],
                ),
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
      _fetchProducts(_getSlugForCity(cityName));
    }
  }

  Widget _buildCityOption(BuildContext context, String cityName, String assetPath) {
    final isSelected = countCity == cityName;
    final slug = _getSlugForCity(cityName);

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async {
        await storage.write(key: 'selected_city_slug', value: slug);
        context.read<CartBloc>().add(const ClearAllProduct());
        Navigator.pop(context, cityName);
      },
      child: Container(
        padding: const EdgeInsets.all(18),
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

  String _getSlugForCity(String cityName) {
    switch (cityName) {
      case 'Алматы':
        // print('almaty');
        return 'almaty';
      case 'Астана':
        // print('astana');
        return 'astana';
      case 'Уральск':
        // print('uralsk');
        return 'uralsk';
      case 'Актобе':
        // print('aktobe');
        return 'aktobe';
      default:
        return '';
    }
  }
}
