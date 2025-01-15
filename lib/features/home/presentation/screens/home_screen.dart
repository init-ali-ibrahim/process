import 'package:flutter/material.dart';
import 'package:process/core/entities/product.dart';
import 'package:process/features/home/data/repo/home_repo.dart';
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
  late HomeRepo repo;

  bool isLoading = true;
  Map<String, List<Product>> categoryProducts = {};

  @override
  void initState() {
    super.initState();
    slugCity = 'almaty';
    repo = HomeRepo();
    getAllProduct();
  }

  Future<void> getAllProduct() async {
    try {
      final result = await repo.getAllProducts(slugCity);
      if (mounted) {
        setState(() {
          categoryProducts = result;
          isLoading = false;
        });
      }
    } catch (e) {
      throw Exception('e_: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const HomeAppbarWidget(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const HomeBannerWidget(),
                  const SizedBox(height: 30),

                  ...categoryProducts.keys.take(5).map((category) {
                    final products = categoryProducts[category]!.take(5);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
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
                  }),
                  const SizedBox(height: 100),
                ],
              ),
            ),
    );
  }
}
