import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/global/entities/product.dart';
import 'package:process/features/home/state/home_state_provider.dart';
import 'package:process/features/home/ui/widgets/home_appbar.dart';
import 'package:process/features/home/ui/widgets/home_banner_widget.dart';
import 'package:process/features/home/ui/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/features/home/ui/widgets/home_horizontal_item_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeState homeState = ref.watch(homeStateProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const HomeAppbar(),
      body: homeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : homeState.error != null
              ? Center(child: Text('Ошибка: ${homeState.error}'))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      const HomeBannerWidget(),
                      const SizedBox(height: 30),

                      ...homeState.products.keys.take(5).map((String category) {
                        Iterable<Product> products = homeState.products[category]!.take(5);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: HomeHorizontalItemTitleWidget(title: category),
                            ),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: products.map((Product product) {
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
