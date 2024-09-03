import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/screens/cart/bloc/cart_bloc.dart';
import 'package:process/screens/cart/widgets/cart_empty_widget.dart';
import 'package:process/screens/color.dart';

// Модель
class Product extends Equatable {
  final String name;
  final double price;
  final String flavor;

  final String colour;
  final String shape;
  final String urlImage;

  Product(this.name, this.price, this.flavor, this.colour, this.shape, this.urlImage);

  @override
  List<Object?> get props => [name, price];
}

// события

// состояния

// Блок

// UI
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  bool _hasShownBottomSheet = false;
  bool _hasBeenTriggeredManually = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_hasShownBottomSheet && _hasBeenTriggeredManually) {
      _showAddressModal(context);
      _hasShownBottomSheet = true;
    }
  }

  final storage = const FlutterSecureStorage();
  var streetCart;
  var districtCart;

  Future<void> _loadData() async {
    try {
      streetCart = await storage.read(key: 'streetCart');
      districtCart = await storage.read(key: 'districtCart');
      setState(() {});
    } catch (e) {
      print('Ошибка при чтении значения: $e');
    }
  }

  final List<Product> _products = [
    Product('украшение 1', 10, 'украшение', '', '',
        'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/decoration%2Fdd.jpeg?alt=media&token=53b9e374-83c0-4bd7-a212-f653a319b30b'),
    Product('украшение 2', 5, 'украшение', '', '',
        'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/decoration%2Fmail.png?alt=media&token=0862f559-ee80-46f1-afd5-870d577f298d'),
  ];

  Future<void> sendCartDataToFirebase(Map<Product, int> cart, User user) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final cartData = cart.entries.map((entry) {
        return {
          'product': {
            'name': entry.key.name,
            'price': entry.key.price,
            'flavor': entry.key.flavor,
            'colour': entry.key.colour.toString(),
            'shape': entry.key.shape.toString(),
          },
          'quantity': entry.value,
        };
      }).toList();

      await firestore.collection('users').doc(user.uid).set({
        'cart': cartData,
        'totalPrice': cart.entries.fold(0.0, (sum, entry) => sum + entry.key.price * entry.value),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные успешно отправлены на Firebase')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при отправке данных: $e')),
      );
    }
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            title: const Text('Корзина'),
            // surfaceTintColor: Colors.white,
            actions: [
              state.cart.isEmpty
                  ? const Text('')
                  : IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return alertClear(dialogContext);
                          },
                        );
                        // context.read<CartBloc>().add(const ClearAllProduct());
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      icon: const Icon(Icons.delete_outlined),
                    )
            ],
          ),
          body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state.cart.isEmpty) {
              return CartEmptyWidget(context);
            } else {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          // height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              return ListView(
                                shrinkWrap: true,
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
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                product.urlImage,
                                                width: 70,
                                                height: 70,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(product.name, style: const TextStyle(fontSize: 14)),
                                                    // Text(product.urlImage, style: TextStyle(fontSize: 14)),
                                                    Text(
                                                      product.flavor as String,
                                                      style: const TextStyle(fontSize: 12, color: Color(0xFF212121)),
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
                                            const SizedBox(),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.remove, size: 18),
                                                  onPressed: () {
                                                    context.read<CartBloc>().add(DecrementProductQuantity(product));
                                                  },
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  '$quantity',
                                                  style: const TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(width: 2),
                                                IconButton(
                                                  icon: const Icon(Icons.add, size: 18),
                                                  onPressed: () {
                                                    context.read<CartBloc>().add(IncrementProductQuantity(product));
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Дополнително на заказ',
                              style: TextStyle(fontSize: 16),
                            )),
                        SizedBox(
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
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: const Color(0xFFDADADA)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(product.urlImage, width: 75, height: 75),
                                    Text(product.name),
                                    Text(
                                      '\₸${product.price}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Получатель',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    color: const Color(0xFFFFFFFF),
                                    border: Border.all(width: 1, color: const Color(0xFFDADADA))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                                    )),
                                    InkWell(
                                      onTap: () {
                                        _showAddressModal(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(bottom: 8, top: 8, left: 10, right: 10),
                                        child: const Row(
                                          children: [
                                            Icon(Icons.add, color: Color(0xFF953282)),
                                            SizedBox(width: 20),
                                            Text(
                                              'Добавление сведений о получателе',
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
                        const SizedBox(height: 10),
                        // Container(
                        //   margin: const EdgeInsets.only(right: 10, left: 10),
                        //   child: InkWell(
                        //     onTap: () {
                        //       setState(() {
                        //         isChecked = !isChecked;
                        //       });
                        //     },
                        //     child: Container(
                        //       decoration: const BoxDecoration(
                        //         color: Color(0xFFEFEFEF),
                        //         borderRadius: BorderRadius.all(Radius.circular(4)),
                        //       ),
                        //       padding: const EdgeInsets.only(right: 12, top: 5, bottom: 5, left: 18),
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           const Text(
                        //             'Держите мою личность в секрете',
                        //             style: TextStyle(fontSize: 16),
                        //           ),
                        //           Checkbox(
                        //             value: isChecked,
                        //             onChanged: (bool? value) {
                        //               setState(() {
                        //                 isChecked = value!;
                        //               });
                        //             },
                        //             fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                        //               if (!states.contains(WidgetState.selected)) {
                        //                 return Colors.white;
                        //               }
                        //               return null;
                        //             }),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                                title: Text('Оставить записку'),
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: 'Напишите сообщение',
                                          hintStyle: TextStyle(fontWeight: FontWeight.w400)),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 200,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(width: 1, color: Color(0xFFDADADA)))),
                      child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Итоговая цена'),
                                Text(
                                  '₸: ${state.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: () async {
                                User? user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  await sendCartDataToFirebase(state.cart, user);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Данные успешно отправлены на Firebase')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Ошибка: пользователь не найден')),
                                  );
                                }
                                Navigator.pushNamed(context, '/profile');
                              },
                              style: TextButton.styleFrom(
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))), backgroundColor: colorPrimary),
                              child: const Text(
                                'Продолжить',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              );
            }
          }));
    });
  }

  //----------------------------

  Widget alertClear(BuildContext dialogContext) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      backgroundColor: Colors.white,
      title: const Text(
        'Очистить корзину',
        style: TextStyle(fontSize: 20),
      ),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Вы уверены?',
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: 80,
                )
              ],
            ),
            SizedBox(
              height: 1,
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Отмена',
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Очистить',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            context.read<CartBloc>().add(const ClearAllProduct());
            Navigator.of(dialogContext).pop();
          },
        ),
      ],
    );
  }
}

void _showAddressModal(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddressModalContent(),
      );
    },
  );
}

class AddressModalContent extends StatefulWidget {
  const AddressModalContent({super.key});

  @override
  _AddressModalContentState createState() => _AddressModalContentState();
}

class _AddressModalContentState extends State<AddressModalContent> {
  String _addressType = 'Курьер';

  final storage = const FlutterSecureStorage();
  String? streetCart;
  String? districtCart;

  final TextEditingController _controllerStreet = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _controllerStreet.dispose();
    _controllerDistrict.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      streetCart = await storage.read(key: 'streetCart');
      districtCart = await storage.read(key: 'districtCart');

      setState(() {
        _controllerStreet.text = streetCart ?? '';
        _controllerDistrict.text = districtCart ?? '';
      });
    } catch (e) {
      print('Ошибка при чтении значения: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                child: Center(
                  child: Text('карта', style: TextStyle(color: Colors.grey[600])),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/map');
                },
              ),
            ),
            const SizedBox(height: 10),
            ToggleButtons(
              isSelected: [
                _addressType == 'Курьер',
                _addressType == 'Самовывоз',
              ],
              onPressed: (int index) {
                setState(() {
                  if (index == 0) _addressType = 'Курьер';
                  if (index == 1) _addressType = 'Самовывоз';
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Курьер'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Самовывоз'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controllerStreet,
              decoration: const InputDecoration(
                labelText: 'Номер адреса',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controllerDistrict,
              decoration: const InputDecoration(
                labelText: 'Район',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Дополнительные указания (по желанию)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Подтвердить'),
            ),
          ],
        ),
      ),
    );
  }
}
