import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:process/core/entities/product.dart';
import 'package:process/features/home/presentation/widgets/home_appbar_widget.dart';
import 'package:process/features/home/presentation/widgets/home_banner_widget.dart';
import 'package:process/features/home/presentation/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/features/home/presentation/widgets/home_horizontal_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late String slugCity;
  bool isLoading = true;
  Map<String, List<Product>> categoryProducts = {};

  @override
  void initState() {
    super.initState();
    slugCity = 'almaty';
    // getAllProduct();
  }

  // Future<void> getAllProduct() async {
  //   try {
  //     final result = await GetFetchProductUseCase(
  //             ProductServiceRepoImpl(FetchProductRemoteDataSource(client)))
  //         .call(slugCity);
  //     if (mounted) {
  //       setState(() {
  //         categoryProducts = result;
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     throw Exception('getAllProduct() tryCatch $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const HomeAppbarWidget(),
        const SliverToBoxAdapter(
          child: HomeBannerWidget(),
        ),
        isLoading
            ? SliverToBoxAdapter(
                child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.2,
                child: Center(
                  child: Text('data'),
                  // child: CircularProgressIndicator(),
                  // child: Container(
                  //   height: 2000,
                  //   color: Colors.red,
                  // ),
                ),
              ))
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final category = categoryProducts.keys.take(5).toList()[index];
                    final products = categoryProducts[category]!.take(5);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HomeHorizontalItemTitleWidget(
                            title: category,
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: products.map((product) {
                              return HomeHorizontalItemWidget(product: product);
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
      ],
    ));
  }
}
