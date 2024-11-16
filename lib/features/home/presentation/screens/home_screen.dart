import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:process/core/entities/product.dart';
import 'package:process/features/home/data/data_sources/fetch_product_service_ds.dart';
import 'package:process/features/home/data/repositories/product_service_repo_impl.dart';
import 'package:process/features/home/domain/use_cases/get_cakes_uc.dart';
import 'package:process/features/home/presentation/widgets/home_appbar_widget.dart';
import 'package:process/screens/color.dart';
import 'package:process/screens/home/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/screens/home/widgets/home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late String slugCity;
  late http.Client client;

  bool isLoading = false;
  Map<String, List<Product>> categoryProducts = {};
  List<Product> categories = [];

  @override
  void initState() {
    super.initState();
    slugCity = 'almaty';
    client = http.Client();
    getAll();
  }

  Future<void> getAll() async {
    final result = await GetFetchProductUseCase(ProductServiceRepoImpl(FetchProductRemoteDataSource(client))).call(slugCity);
    categoryProducts = result;
    // print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const HomeAppbarWidget(),
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      // const HomeBannerWidget(),
                      HomeHorizontalItemTitleWidget(
                        title: 'Торты',
                        icon: Icons.access_time_filled,
                      ),
                      const SizedBox(
                        height: 280,
                      ),
                      HomeHorizontalItemTitleWidget(
                        title: 'Десерты',
                        icon: Icons.access_time_filled,
                      ),
                      const SizedBox(
                        height: 280,
                      ),
                      HomeHorizontalItemTitleWidget(
                        title: 'Выпечка',
                        icon: Icons.access_time_filled,
                      ),
                      const SizedBox(
                        height: 280,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ))
                ],
              ));
  }
}
