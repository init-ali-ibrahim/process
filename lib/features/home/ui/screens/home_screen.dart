import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/global/entities/product.dart';
import 'package:process/features/home/state/home_state_provider.dart';
import 'package:process/features/home/ui/widgets/home_appbar.dart';
import 'package:process/features/home/ui/widgets/home_banner.dart';
import 'package:process/features/home/ui/widgets/home_horizontal_item_title_widget.dart';
import 'package:process/features/home/ui/widgets/home_horizontal_item_widget.dart';
import 'package:process/features/home/ui/widgets/shimmer/home_banner_shimmer.dart';
import 'package:process/features/home/ui/widgets/shimmer/home_horizontal_item_shimmer.dart';
import 'package:process/features/home/ui/widgets/shimmer/home_horizontal_item_title_shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeState homeState = ref.watch(homeStateProvider);

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      backgroundColor: Colors.white,
      appBar: HomeAppbar(),
      body: homeState.error != null
          ? Center(child: Text('e: ${homeState.error}'))
          : SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: homeState.isLoading
                        ? const HomeBannerShimmer(key: ValueKey<dynamic>('shimmer_banner'))
                        : const HomeBanner(key: ValueKey<dynamic>('actual_banner')),
                  ),
                  const SizedBox(height: 30),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: homeState.isLoading
                        ? const _LoadingShimmerContent(key: ValueKey<dynamic>('shimmer_content'))
                        : _ActualContent(
                            categories: homeState.products.keys.take(5).toList(),
                            products: homeState.products,
                            key: const ValueKey<dynamic>('actual_content'),
                          ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
    );
  }
}

class _LoadingShimmerContent extends StatelessWidget {
  const _LoadingShimmerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: HomeHorizontalItemTitleShimmer(),
        ),
        SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              HomeHorizontalItemShimmer(),
              HomeHorizontalItemShimmer(),
              HomeHorizontalItemShimmer(),
              HomeHorizontalItemShimmer(),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: HomeHorizontalItemTitleShimmer(),
        ),
        SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              HomeHorizontalItemShimmer(),
              HomeHorizontalItemShimmer(),
              HomeHorizontalItemShimmer(),
              HomeHorizontalItemShimmer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActualContent extends StatelessWidget {
  final List<String> categories;
  final Map<String, List<Product>> products;

  const _ActualContent({
    required this.categories,
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((String category) {
        Iterable<Product> categoryProducts = products[category]!.take(5);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: HomeHorizontalItemTitleWidget(title: category),
            ),
            SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryProducts.map((Product product) {
                  return HomeHorizontalItemWidget(product: product);
                }).toList(),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
