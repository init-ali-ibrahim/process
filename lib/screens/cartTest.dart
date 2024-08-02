//
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:process/screens/cake_create.dart';
//
// // Define the NoCart Event
// abstract class NoCartEvent extends Equatable {
//   const NoCartEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class CakeAddedToNoCart extends NoCartEvent {
//   final CakeCustomizationState cake;
//
//   const CakeAddedToNoCart(this.cake);
//
//   @override
//   List<Object> get props => [cake];
// }
//
// // Define the NoCart State
// class NoCartState extends Equatable {
//   final List<CakeCustomizationState> cakes;
//
//   const NoCartState({this.cakes = const []});
//
//   NoCartState copyWith({List<CakeCustomizationState>? cakes}) {
//     return NoCartState(
//       cakes: cakes ?? this.cakes,
//     );
//   }
//
//   @override
//   List<Object> get props => [cakes];
// }
//
// // Define the NoCart Bloc
// class NoCartBloc extends Bloc<NoCartEvent, NoCartState> {
//   NoCartBloc() : super(const NoCartState());
//
//   @override
//   Stream<NoCartState> mapEventToState(NoCartEvent event) async* {
//     if (event is CakeAddedToNoCart) {
//       final List<CakeCustomizationState> updatedCakes = List.from(state.cakes)..add(event.cake);
//       yield state.copyWith(cakes: updatedCakes);
//     }
//   }
// }
//
// class NoCartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Корзина', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
//       ),
//       body: BlocBuilder<NoCartBloc, NoCartState>(
//         builder: (context, state) {
//           if (state.cakes.isEmpty) {
//             return const Center(
//               child: Text('Ваша корзина пуста'),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: state.cakes.length,
//               itemBuilder: (context, index) {
//                 final cake = state.cakes[index];
//                 return ListTile(
//                   title: Text('${cake.shapeName} - ${cake.flavorName} - ${cake.colourName}'),
//                   subtitle: Text('\$${cake.totalPrice.toStringAsFixed(2)}'),
//                   leading: Image.network(cake.imagePath),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../color.dart';
import 'cake_template.dart';

// Модель
class Product extends Equatable {
  final String name;
  final double price;
  final String flavor;
  final Colour colour;
  final Shape shape;

  Product(this.name, this.price, this.flavor, this.colour, this.shape);

  @override
  List<Object?> get props => [name, price];
}

// события
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddProduct extends CartEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveProduct extends CartEvent {
  final Product product;

  const RemoveProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class IncrementProductQuantity extends CartEvent {
  final Product product;

  const IncrementProductQuantity(this.product);

  @override
  List<Object?> get props => [product];
}

class DecrementProductQuantity extends CartEvent {
  final Product product;

  const DecrementProductQuantity(this.product);

  @override
  List<Object?> get props => [product];
}

// состояния
class CartState extends Equatable {
  final Map<Product, int> cart;

  const CartState(this.cart);

  @override
  List<Object?> get props => [cart];
}

// Блок
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState({})) {
    on<AddProduct>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      if (newCart.containsKey(event.product)) {
        newCart[event.product] = newCart[event.product]! + 1;
      } else {
        newCart[event.product] = 1;
      }
      emit(CartState(newCart));
    });

    on<RemoveProduct>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      newCart.remove(event.product);
      emit(CartState(newCart));
    });

    on<IncrementProductQuantity>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      newCart[event.product] = newCart[event.product]! + 1;
      emit(CartState(newCart));
    });

    on<DecrementProductQuantity>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      if (newCart[event.product]! > 1) {
        newCart[event.product] = newCart[event.product]! - 1;
      } else {
        newCart.remove(event.product);
      }
      emit(CartState(newCart));
    });
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<Product> _products = [
    Product('украшение 1', 10, 'украшение', Colour.Red, Shape.HeartDone),
    Product('украшение 2', 5, 'украшение', Colour.Red, Shape.HeartDone),

    // Product('nomer 2', 20.0),
    // Product('nomer 3', 30.0),
  ];

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F9),

          title: Text('Корзина'),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.shopping_cart),
          //     onPressed: () {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(builder: (_) => CartScreen()),
          //       );
          //     },
          //   ),
          // ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return ListView(
                          children: state.cart.entries.map((entry) {
                            final product = entry.key;
                            final quantity = entry.value;
                            return Container(
                              height: 90,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: const Color(0xFFDADADA))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Image(image: AssetImage('assets/1.png')),
                                      const SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(product.name, style: TextStyle(fontSize: 14)),
                                              Text(
                                                product.flavor as String,
                                                style: TextStyle(fontSize: 12, color: Color(0xFF212121)),
                                              ),
                                            ],
                                          ),
                                          Text('$quantity * ${product.price} = ${quantity * product.price}',
                                              style: const TextStyle(fontSize: 12, color: Color(0xFF212121)))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove, size: 18),
                                            onPressed: () {
                                              context.read<CartBloc>().add(DecrementProductQuantity(product));
                                            },
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '$quantity',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(width: 2),
                                          IconButton(
                                            icon: Icon(Icons.add, size: 18),
                                            onPressed: () {
                                              context.read<CartBloc>().add(IncrementProductQuantity(product));
                                            },
                                          ),
                                          // const SizedBox(width: 5),
                                          // IconButton(
                                          //   icon: Icon(Icons.add),
                                          //   onPressed: () {
                                          //     context.read<CartBloc>().add(IncrementProductQuantity(product));
                                          //   },
                                          // ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );

                            //   ListTile(
                            //   title: Text(product.name, style: TextStyle(fontSize: 15, color: Colors.red)),
                            //   subtitle: Text('Сколько: $quantity + ${product.price} = ${quantity * product.price}'),
                            //   trailing: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       IconButton(
                            //         icon: Icon(Icons.remove),
                            //         onPressed: () {
                            //           context.read<CartBloc>().add(DecrementProductQuantity(product));
                            //         },
                            //       ),
                            //       IconButton(
                            //         icon: Icon(Icons.add),
                            //         onPressed: () {
                            //           context.read<CartBloc>().add(IncrementProductQuantity(product));
                            //         },
                            //       ),
                            //       IconButton(
                            //         icon: Icon(Icons.delete),
                            //         onPressed: () {
                            //           context.read<CartBloc>().add(RemoveProduct(product));
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  // SizedBox(
                  //   height: 150,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ListView.builder(
                  //     itemCount: _products.length,
                  //     itemBuilder: (context, index) {
                  //       final product = _products[index];
                  //       return ListTile(
                  //         title: Text('${product.name} + ${product.flavor} +${product.shape} + ${product.colour}'),
                  //         subtitle: Text('\$${product.price}'),
                  //         trailing: ElevatedButton(
                  //           onPressed: () {
                  //             context.read<CartBloc>().add(AddProduct(product));
                  //           },
                  //           child: Text('pakupka'),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: 30,),

                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            // color: const Color(0xFFD99D9B),
                            // borderRadius: BorderRadius.circular(10),
                            // border: Border.all(width: 1, color: colorPrimary)
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            border: Border.all(width: 1, color: const Color(0xFFDADADA)),
                        ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/1.png', width: 75, height: 75),
                              Text(product.name),
                              Text('\$${product.price}', style: TextStyle(fontSize: 13),),
                              IconButton(
                                icon: const Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  context.read<CartBloc>().add(AddProduct(product));
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recipient',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              color: const Color(0xFFFFFFFF),
                              border: Border.all(width: 1, color: Color(0xFFDADADA))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                              )),
                              InkWell(
                                onTap: () async {
                                  // showRecipient(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 8, top: 8, left: 10, right: 10),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.add, color: Color(0xFF953282)),
                                      SizedBox(width: 20),
                                      Text(
                                        'Add recipient details',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        padding: const EdgeInsets.only(right: 12, top: 5, bottom: 5, left: 18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Держите мою личность в секрете',
                              style: TextStyle(fontSize: 16),
                            ),
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                              fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                                if (!states.contains(MaterialState.selected)) {
                                  return Colors.white;
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: const ExpansionTile(
                          backgroundColor: Color(0xFFEFEFEF),
                          collapsedBackgroundColor: Color(0xFFEFEFEF),
                          iconColor: Colors.black,
                          leading: Icon(Icons.add),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                          title: Text('Оставить записку на cake'),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Напишите сообщение на cake',
                                  hintStyle: TextStyle(fontWeight: FontWeight.w400)
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              // top: 0,
              left: 0,
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(width: 1, color: Color(0xFFDADADA)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Итоговая цена'),
                        Text(
                          '₸ 15.8',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () => widget,
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))), backgroundColor: colorPrimary),
                      child: const Text(
                        'Продолжить',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Cwwwart'),
//       // ),
//       body: BlocBuilder<CartBloc, CartState>(
//         builder: (context, state) {
//           return ListView(
//             children: state.cart.entries.map((entry) {
//               final product = entry.key;
//               final quantity = entry.value;
//               return ListTile(
//                 title: Text(product.name),
//                 subtitle: Text('Quantity: $quantity'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.remove),
//                       onPressed: () {
//                         context.read<CartBloc>().add(DecrementProductQuantity(product));
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.add),
//                       onPressed: () {
//                         context.read<CartBloc>().add(IncrementProductQuantity(product));
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         context.read<CartBloc>().add(RemoveProduct(product));
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
