import 'package:flutter/material.dart';
import 'package:process/color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process/screens/cake_template.dart';

// models/product.dart
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

// models/cart_item.dart
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}

// bloc/cart_event.dart
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddCakeToCart extends CartEvent {
  final Shape shape;
  final Flavor flavor;
  final Colour colour;
  final double price;
  final String imageUrl;

  const AddCakeToCart({
    required this.shape,
    required this.flavor,
    required this.colour,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [shape, flavor, colour, price, imageUrl];
}

class AddProductToCart extends CartEvent {
  final Product product;

  const AddProductToCart(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProductFromCart extends CartEvent {
  final Product product;

  const RemoveProductFromCart(this.product);

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {}

// bloc/cart_state.dart
class CartState extends Equatable {
  final List<CartItem> items;
  final double totalPrice;

  const CartState({
    required this.items,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [items, totalPrice];
}

// bloc/cart_bloc.dart
// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc()
//       : super(const CartState(items: [], totalPrice: 0.0)) {
//     on<AddProductToCart>(_onAddProductToCart);
//     on<RemoveProductFromCart>(_onRemoveProductFromCart);
//     on<ClearCart>(_onClearCart);
//   }
//
//   void _onAddProductToCart(AddProductToCart event, Emitter<CartState> emit) {
//     final state = this.state;
//     List<CartItem> updatedItems = List.from(state.items);
//     CartItem? existingItem = updatedItems.firstWhere(
//           (item) => item.product.id == event.product.id,
//       orElse: () => CartItem(product: event.product, quantity: 0),
//     );
//
//     if (existingItem.quantity == 0) {
//       updatedItems.add(existingItem);
//     }
//
//     if (existingItem.quantity < 20) {
//       existingItem.quantity++;
//     }
//     // existingItem.quantity++;
//
//     double updatedTotalPrice = updatedItems.fold(0, (total, item) => total + item.totalPrice);
//
//     emit(CartState(items: updatedItems, totalPrice: updatedTotalPrice));
//   }
//
//   void _onRemoveProductFromCart(RemoveProductFromCart event, Emitter<CartState> emit) {
//     final state = this.state;
//     List<CartItem> updatedItems = List.from(state.items);
//     CartItem? existingItem = updatedItems.firstWhere(
//           (item) => item.product.id == event.product.id,
//       orElse: () => CartItem(product: event.product, quantity: 0),
//     );
//
//     if (existingItem.quantity > 1) {
//       existingItem.quantity--;
//     } else {
//       updatedItems.remove(existingItem);
//     }
//
//     double updatedTotalPrice = updatedItems.fold(0, (total, item) => total + item.totalPrice);
//
//     emit(CartState(items: updatedItems, totalPrice: updatedTotalPrice));
//   }
//
//   void _onClearCart(ClearCart event, Emitter<CartState> emit) {
//     emit(const CartState(items: [], totalPrice: 0.0));
//   }
// }

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [], totalPrice: 0.0)) {
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<ClearCart>(_onClearCart);
    on<AddCakeToCart>(_onAddCakeToCart);
  }

  void _onAddProductToCart(AddProductToCart event, Emitter<CartState> emit) {
    final state = this.state;
    List<CartItem> updatedItems = List.from(state.items);
    CartItem? existingItem = updatedItems.firstWhere(
      (item) => item.product.id == event.product.id,
      orElse: () => CartItem(product: event.product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      updatedItems.add(existingItem);
    }

    if (existingItem.quantity < 20) {
      existingItem.quantity++;
    }

    double updatedTotalPrice = updatedItems.fold(0, (total, item) => total + item.totalPrice);

    emit(CartState(items: updatedItems, totalPrice: updatedTotalPrice));
  }

  void _onRemoveProductFromCart(RemoveProductFromCart event, Emitter<CartState> emit) {
    final state = this.state;
    List<CartItem> updatedItems = List.from(state.items);
    CartItem? existingItem = updatedItems.firstWhere(
      (item) => item.product.id == event.product.id,
      orElse: () => CartItem(product: event.product, quantity: 0),
    );

    if (existingItem.quantity > 1) {
      existingItem.quantity--;
    } else {
      updatedItems.remove(existingItem);
    }

    double updatedTotalPrice = updatedItems.fold(0, (total, item) => total + item.totalPrice);

    emit(CartState(items: updatedItems, totalPrice: updatedTotalPrice));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState(items: [], totalPrice: 0.0));
  }

  void _onAddCakeToCart(AddCakeToCart event, Emitter<CartState> emit) {
    final state = this.state;
    List<CartItem> updatedItems = List.from(state.items);
    Product cakeProduct = Product(
      id: '${event.shape}-${event.flavor}-${event.colour}',
      name: '${shapeName[event.shape]} ${flavorName[event.flavor]} ${colourName[event.colour]}',
      price: event.price,
      imageUrl: event.imageUrl,
    );

    CartItem? existingItem = updatedItems.firstWhere(
      (item) => item.product.id == cakeProduct.id,
      orElse: () => CartItem(product: cakeProduct, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      updatedItems.add(existingItem);
    }
    existingItem.quantity++;

    double updatedTotalPrice = updatedItems.fold(0, (total, item) => total + item.totalPrice);

    emit(CartState(items: updatedItems, totalPrice: updatedTotalPrice));
  }
}

// UI
class cart_screen extends StatelessWidget {
  final List<Product> products = [
    Product(id: '1', name: 'Cake 1', price: 20.0, imageUrl: 'assets/00.png'),
    Product(id: '2', name: 'Cake 2', price: 30.0, imageUrl: 'assets/00.png'),
  ];


  bool isChecked = false;
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: const Color(0xFFF9F9F9),
  //       appBar: AppBar(
  //         backgroundColor: const Color(0xFFF9F9F9),
  //         title: const Text(
  //           'Cart',
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  //         ),
  //       ),
  //       body: Column(
  //         children: [
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           const Center(
  //             child: Icon(
  //               Icons.add_a_photo_rounded,
  //               size: 120,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           const Center(child: Text('Your Cart is Emptyy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           const Center(
  //               child: Text(
  //             'Looks like you have note made your choice yet',
  //             style: TextStyle(fontSize: 16),
  //           )),
  //           const SizedBox(
  //             height: 50,
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pushNamed(context, '/cake_create');
  //             },
  //             style: TextButton.styleFrom(
  //               backgroundColor: colorLight,
  //               minimumSize: Size(MediaQuery.of(context).size.width - 120, 10),
  //               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
  //             ),
  //             child: const Text(
  //               'Мake your cake',
  //               style: TextStyle(color: Colors.white, fontSize: 18),
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F9),
          title: const Text(
            'Cart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                context.read<CartBloc>().add(ClearCart());
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        // color: const Color(0xFFD99D9B),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: colorPrimary)),
                    child: Column(
                      children: [
                        Image.asset(product.imageUrl, width: 70, height: 70),
                        Text(product.name),
                        Text('\$${product.price}'),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            context.read<CartBloc>().add(AddProductToCart(product));
                          },
                        ),
                      ],
                    ),
                    // leading: Image.asset(product.imageUrl, width: 50, height: 50),
                    // title: Text(product.name),
                    // subtitle: Text('\$${product.price}'),
                    // trailing: IconButton(
                    //   icon: Icon(Icons.add_shopping_cart),
                    //   onPressed: () {
                    //     context.read<CartBloc>().add(AddProductToCart(product));
                    //   },
                    // ),
                  );

                  // ListTile(
                  //   leading: Image.asset(product.imageUrl, width: 50, height: 50),
                  //   title: Text(product.name),
                  //   subtitle: Text('\$${product.price}'),
                  //   trailing: IconButton(
                  //     icon: Icon(Icons.add_shopping_cart),
                  //     onPressed: () {
                  //       context.read<CartBloc>().add(AddProductToCart(product));
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Text(
                        'tootal: \$${state.totalPrice}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            final item = state.items[index];
                            return ListTile(
                              leading: Image.asset(item.product.imageUrl, width: 50, height: 50),
                              title: Text(item.product.name),
                              subtitle: Text('${item.quantity} x \$${item.product.price}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      context.read<CartBloc>().add(RemoveProductFromCart(item.product));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      context.read<CartBloc>().add(AddProductToCart(item.product));
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),


            // SizedBox(
            //   height: 40,
            // ),
            // Container(
            //   width: 200,
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.red.withOpacity(0.2),
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.elliptical(10, 50),
            //         topRight: Radius.elliptical(10, 50),
            //         bottomRight: Radius.elliptical(10, 50),
            //         bottomLeft: Radius.elliptical(10, 50),
            //       )),
            //   child: InkWell(
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.elliptical(10, 50),
            //         topRight: Radius.elliptical(10, 50),
            //         bottomRight: Radius.elliptical(10, 50),
            //         bottomLeft: Radius.elliptical(10, 50),
            //       ),
            //       onTap: () {},
            //       child: Container(
            //         color: Colors.blue.withOpacity(0.2),
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}
