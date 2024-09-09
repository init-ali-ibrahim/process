import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/screens/cart/bloc/cart_bloc.dart';
import 'package:process/screens/cart/widgets/cart_empty_widget.dart';
import 'package:process/screens/color.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

// Модель
class Product extends Equatable {
  final String name;
  final int price;
  final String flavor;

  final String colour;
  final String shape;
  final String urlImage;
  final int product_id;
  final String product_type;
  final String comment;
  final File imgApi;

  Product(this.name, this.price, this.flavor, this.colour, this.shape, this.urlImage, this.product_id, this.product_type, this.comment, this.imgApi);

  @override
  List<Object?> get props => [name, price];
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  bool _hasShownBottomSheet = false;
  final bool _hasBeenTriggeredManually = false;
  final storage = const FlutterSecureStorage();
  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isChecked = false;
  var streetCart;
  var districtCart;

  final LatLng position = const LatLng(43.220189, 76.876802);

  // final slug = await storage.read(key: 'selected_city_slug');


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
    _loadData();
    setState(() {});

    if (state == AppLifecycleState.resumed && !_hasShownBottomSheet && _hasBeenTriggeredManually) {
      _loadData().then((_) {
        setState(() {});
        Future.delayed(Duration(milliseconds: 100), () {
          _showAddressModal(context);
        });
        _hasShownBottomSheet = true;
      });
    }
  }

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
    Product(
        'украшение 1',
        10,
        '',
        '',
        '',
        'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/decoration%2Fdd.jpeg?alt=media&token=53b9e374-83c0-4bd7-a212-f653a319b30b',
        998,
        '',
        '',
        File('')),
    Product(
        'украшение 2',
        5,
        '',
        '',
        '',
        'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/decoration%2Fmail.png?alt=media&token=0862f559-ee80-46f1-afd5-870d577f298d',
        999,
        '',
        '',
        File('')),
  ];

  // Future sendOrder({
  //   required List<Map<String, dynamic>> products,
  //   required String name,
  //   required String phone,
  //   required String deliveryType,
  //   required String address,
  // }) async {
  //   const url = 'http://192.168.1.109:80/api/v1/app/orders';
  //   String? tokenAuth = await storage.read(key: 'token');
  //
  //   print('$tokenAuth AAAAAAAAAAAAAAAAAAAAAAAA');
  //
  //   final headers = {
  //     'Authorization': 'Bearer $tokenAuth',
  //     'City': 'almaty',
  //     'Content-Type': 'multipart/form-data',
  //     // 'Content-Type': 'application/json',
  //   };
  //
  //   final body = jsonEncode({
  //     'products': products,
  //     'name': name,
  //     'phone': phone,
  //     'delivery_type': deliveryType,
  //     'address': address,
  //   });
  //
  //   print('Body: $body');
  //
  //   try {
  //     final response = await http.post(Uri.parse(url), headers: headers, body: body);
  //
  //     print('Body: $body');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('Order sent successfully');
  //     } else {
  //       print('Failed to send order: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // final storage = FlutterSecureStorage();

  Future<void> sendOrder({
    required List<Map<String, dynamic>> products,
    // required String name,
    // required String phone,
    required String deliveryType,
    required String address,
  }) async {
    const url = 'http://192.168.0.219:80/api/v1/app/orders';
    String? tokenAuth = await storage.read(key: 'token');

    String cleanedPhone = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');

    print(cleanedPhone);

    if (tokenAuth == null) {
      print('No token found!');
      return;
    }

    final TextEditingController _commentController = TextEditingController();
    // final TextEditingController _nameController = TextEditingController();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll({
          'Authorization': 'Bearer $tokenAuth',
          'City': 'almaty',
        })
        ..fields['name'] = _nameController.text
        ..fields['phone'] = cleanedPhone
        ..fields['delivery_type'] = deliveryType
        ..fields['address'] = address
        ..fields['comments'] = _commentController.text;

      // Добавление продуктов и изображений
      for (int i = 0; i < products.length; i++) {
        var product = products[i];
        if (product['type'] == 'costume') {
          var costumeProducts = product['costume_products'] as Map<String, dynamic>;

          // Проверка наличия изображения и его типа
          if (costumeProducts['img'] != null && costumeProducts['img'] is String) {
            String imgPath = costumeProducts['img'];
            var mimeType = lookupMimeType(imgPath);
            if (mimeType != null) {
              var mimeParts = mimeType.split('/');
              var file = await http.MultipartFile.fromPath(
                'products[$i][costume_products][img]',
                imgPath,
                contentType: MediaType(mimeParts[0], mimeParts[1]),
              );
              request.files.add(file);
            }
          } else {
            print('Invalid image path: ${costumeProducts['img']}');
          }

          // Добавление полей для костюма
          request.fields['products[$i][type]'] = 'costume';
          request.fields['products[$i][costume_products][color]'] = costumeProducts['color'];
          request.fields['products[$i][costume_products][shape]'] = costumeProducts['shape'];
          request.fields['products[$i][costume_products][flavor]'] = costumeProducts['flavor'];
          request.fields['products[$i][costume_products][comments]'] = costumeProducts['comments'];
          request.fields['products[$i][quantity]'] = product['quantity'].toString();
          request.fields['products[$i][price]'] = product['price'].toString();
        } else {
          // Обработка стандартного продукта
          request.fields['products[$i][type]'] = 'standard';
          request.fields['products[$i][product_id]'] = product['product_id'].toString();
          request.fields['products[$i][quantity]'] = product['quantity'].toString();
        }
      }

      // print(request.)

      // Отправка запроса
      final response = await request.send();
      print('Response status code: ${response.statusCode}');
      final responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Order sent successfully');
      } else {
        print('Failed to send order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
                  ? const SizedBox()
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
                                              child: FadeInImage.assetNetwork(
                                                  placeholder: 'assets/image/loadingItem.jpg',
                                                  image: product.urlImage,
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,
                                                  imageErrorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      color: Colors.white,
                                                      width: 70,
                                                      height: 70,
                                                    );
                                                  }),
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(product.name, style: const TextStyle(fontSize: 14)),
                                                // Text('${product.product_id}'),

                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  child: Text('₸ ${product.price}', style: const TextStyle(fontSize: 12), softWrap: true),
                                                )

                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          height: 180,
                          child: ListView.builder(
                            itemCount: _products.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final product = _products[index];
                              return Container(
                                width: 120,
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: const Color(0xFFDADADA)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: Image.network(product.urlImage, width: 75, height: 75),
                                    ),
                                    Text(product.name),
                                    TextButton(
                                      onPressed: () {
                                        context.read<CartBloc>().add(AddProduct(product));
                                      },
                                      style: TextButton.styleFrom(backgroundColor: Colors.red.shade50, minimumSize: const Size(100, 10)),
                                      child: Text(
                                        '\₸ ${product.price}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        //

                        //
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
                              const SizedBox(height: 14),
                              TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskFormatter],
                                decoration: InputDecoration(
                                  hintText: '+7 (700) 000-00-00',
                                  labelText: 'Введите номер получателя',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                              const SizedBox(height: 14),
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Введите имя получателя',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                              const SizedBox(height: 14),
                              InkWell(
                                  onTap: () {
                                    _showAddressModal(context);
                                  },
                                  child: Container(
                                    height: 140,
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
                                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                                                child: Stack(
                                                  children: [
                                                    GoogleMap(
                                                      initialCameraPosition: CameraPosition(
                                                        target: position,
                                                        zoom: 10.0,
                                                      ),
                                                      // onTap: (){_showAddressModal(position);},
                                                      zoomControlsEnabled: false,
                                                      buildingsEnabled: false,
                                                      compassEnabled: false,
                                                      fortyFiveDegreeImageryEnabled: false,
                                                      indoorViewEnabled: false,
                                                      liteModeEnabled: false,
                                                      myLocationButtonEnabled: false,
                                                      trafficEnabled: false,
                                                      zoomGesturesEnabled: false,
                                                      myLocationEnabled: false,
                                                      scrollGesturesEnabled: false,
                                                      tiltGesturesEnabled: false,
                                                      rotateGesturesEnabled: false,
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                        color: Colors.red.withOpacity(0),
                                                        width: MediaQuery.of(context).size.width,
                                                        height: MediaQuery.of(context).size.width,
                                                      ),
                                                    )
                                                  ],
                                                ))),
                                        // InkWell(
                                        //   onTap: () {
                                        //     _showAddressModal(context);
                                        //   },
                                        //   child:

                                          Container(
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
                                        // )
                                      ],
                                    ),
                                  ))
                            ],
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
                              child: ExpansionTile(
                                backgroundColor: const Color(0xFFEFEFEF),
                                collapsedBackgroundColor: const Color(0xFFEFEFEF),
                                iconColor: Colors.black,
                                leading: const Icon(Icons.add),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                title: const Text('Оставить записку'),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      controller: _commentController,
                                      decoration: const InputDecoration(
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
                                  '₸: ${state.totalPrice}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: () async {
                                String? storedValue = await storage.read(key: "typeAdress");
                                print(storedValue);

                                try {
                                  final productsSamal = state.cart.entries.map((entry) {
                                    final productsSamal = entry.key;
                                    final quantity = entry.value;

                                    print(productsSamal.imgApi.path);

                                    if (productsSamal.product_type == 'costume') {
                                      return {
                                        'type': 'costume',
                                        'quantity': quantity,
                                        'costume_products': {
                                          'color': productsSamal.colour,
                                          'shape': productsSamal.shape,
                                          'flavor': productsSamal.flavor,
                                          'comments': productsSamal.comment,
                                          'img': productsSamal.imgApi.path,
                                        },
                                        'price': 123
                                      };
                                    } else {
                                      return {
                                        'type': 'standard',
                                        'product_id': productsSamal.product_id,
                                        'quantity': quantity,
                                      };
                                    }
                                  }).toList();

                                  await sendOrder(
                                    products: productsSamal,
                                    deliveryType: '$storedValue',
                                    address: 'asdas',

                                    // deliveryType: 'pickup',
                                    // name: _commentController.text,
                                    // phone: '77066223709',
                                  );
                                } catch (e) {
                                  print('Error: $e');
                                }
                              },
                              style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                                backgroundColor: colorPrimary,
                              ),
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

  void _showAddressModal(BuildContext context) async {
    await _loadData();

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
          child: AddressModalContent(
            streetCart: streetCart,
            districtCart: districtCart,
          ),
        );
      },
    );
  }
}

class AddressModalContent extends StatefulWidget {
  final String? streetCart;
  final String? districtCart;

  const AddressModalContent({
    super.key,
    this.streetCart,
    this.districtCart,
  });

  @override
  _AddressModalContentState createState() => _AddressModalContentState();
}

class _AddressModalContentState extends State<AddressModalContent> {
  String _addressType = 'Курьер';
  late TextEditingController _controllerStreet;
  late TextEditingController _controllerDistrict;
  final storage = const FlutterSecureStorage();
  final LatLng position = const LatLng(43.220189, 76.876802);


  Future<void> _loadAddressType() async {
    String? storedType = await storage.read(key: 'typeAdress');
    if (storedType != null) {
      setState(() {
        _addressType = storedType == 'pickup' ? 'Самовывоз' : 'Курьер';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAddressType();
    _controllerStreet = TextEditingController(text: widget.streetCart ?? '');
    _controllerDistrict = TextEditingController(text: widget.districtCart ?? '');
  }

  @override
  void dispose() {
    _controllerStreet.dispose();
    _controllerDistrict.dispose();
    super.dispose();
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
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: position,
                        zoom: 10.0,
                      ),
                      // onTap: (){_showAddressModal(position);},
                      zoomControlsEnabled: false,
                      buildingsEnabled: false,
                      compassEnabled: false,
                      fortyFiveDegreeImageryEnabled: false,
                      indoorViewEnabled: false,
                      liteModeEnabled: false,
                      myLocationButtonEnabled: false,
                      trafficEnabled: false,
                      zoomGesturesEnabled: false,
                      myLocationEnabled: false,
                      scrollGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        color: Colors.red.withOpacity(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                      ),
                    )
                  ],
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
              onPressed: (int index) async {
                setState(() {
                  if (index == 0) _addressType = 'Курьер';
                  if (index == 1) _addressType = 'Самовывоз';
                });

                if (index == 1){
                  await storage.write(key: 'typeAdress', value: 'pickup');
                } else {
                  await storage.write(key: 'typeAdress', value: 'delivery');
                }

                // String? storedValue = await storage.read(key: "typeAdress");
                // print('Stored value: $storedValue');

                setState(() {});
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
