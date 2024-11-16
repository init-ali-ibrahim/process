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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
    // Future.wait(Iterable.empty());
    final result = await GetFetchProductUseCase(
            ProductServiceRepoImpl(FetchProductRemoteDataSource(client)))
        .call(slugCity);
    setState(() {
      categoryProducts = result;
    });
    print(result);
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
                  ...categoryProducts.entries.map((entry) {
                    final category = entry.key;
                    final products = entry.value;

                    return SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          ...products.map((product) {
                            return ListTile(
                              title: Text(product.name),
                              subtitle: Text(
                                  'Slug: ${product.slug}, Quantity: ${product.quantity}'),
                            );
                          }),
                          const Divider(),
                        ],
                      ),
                    );
                  }),
                  // SliverToBoxAdapter(
                  //     child: Column(
                  //   children: [
                  //     ListView(
                  //       shrinkWrap: true,
                  //       children: categoryProducts.entries.map((entry) {
                  //         final category = entry.key;
                  //         final products = entry.value;
                  //
                  //         return ExpansionTile(
                  //           title: Text(category,
                  //               style: const TextStyle(
                  //                   fontWeight: FontWeight.bold)),
                  //           children: products.map((product) {
                  //             return ListTile(
                  //               title: Text(product.name),
                  //               subtitle: Text(
                  //                   'Slug: ${product.slug}, Quantity: ${product.quantity}'),
                  //             );
                  //           }).toList(),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ],
                  // ))
                ],
              ));
  }
}
