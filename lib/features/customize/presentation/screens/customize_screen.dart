import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:process/screens/cake_create/bloc/cake_customization_bloc.dart';
import 'package:process/screens/cart/bloc/cart_bloc.dart';
import 'package:process/screens/cart/cart_screen.dart';
import 'package:process/screens/connection.dart';
import 'package:process/screens/navbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';

// UI
class CakeCustomizationScreen extends StatefulWidget {
  const CakeCustomizationScreen({super.key});

  @override
  State<CakeCustomizationScreen> createState() => _CakeCustomizationScreenState();
}

class _CakeCustomizationScreenState extends State<CakeCustomizationScreen> {
  String? chosenAnimation;
  String? chosenTexture;

  late final WebViewController _controller;

  var link = 'assets/models/circle.glb';

  String currentSelection = 'Shape';

  void _onSelectionChanged(String selection) {
    setState(() {
      currentSelection = selection;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   late final PlatformWebViewControllerCreationParams params;
  //   if (WebViewPlatform.instance is WebKitWebViewPlatform) {
  //     params = WebKitWebViewControllerCreationParams(
  //       allowsInlineMediaPlayback: true,
  //       mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
  //     );
  //   } else {
  //     params = const PlatformWebViewControllerCreationParams();
  //   }
  //
  //   final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
  //
  //   controller
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..addJavaScriptChannel(
  //       'Toaster',
  //       onMessageReceived: (JavaScriptMessage message) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       },
  //     )
  //     ..loadRequest(Uri.parse('http://192.168.0.219:5173/'));
  //
  //   if (kIsWeb || !Platform.isMacOS) {
  //     controller.setBackgroundColor(const Color(0x00000000));
  //   }
  //   if (controller.platform is AndroidWebViewController) {
  //     AndroidWebViewController.enableDebugging(true);
  //     (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
  //   }
  //   _controller = controller;
  // }

  var urlToCart;

  Widget _buildSelection(BuildContext context) {
    switch (currentSelection) {
      case 'Shape':
        return _buildShapeSelection(context);
      case 'Flavor':
        return _buildFlavorSelection(context);
      case 'Colour':
        return _buildColourSelection(context);
      case 'Topping':
        return const buildCustomSelection();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CakeCustomizationBloc(),
      child: BlocBuilder<CakeCustomizationBloc, CakeCustomizationState>(builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
              title: const Text('Кастомизация'),
              actions: [
                Text(
                  'сумма: \₸${state.totalPrice}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 20)
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(300),
                child: Container(
                    child: SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        // child: Text('$link')
                        child: WebViewWidget(controller: _controller))),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        width: 90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            InkWell(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 70,
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  color: currentSelection == 'Shape' ? Colors.white : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.cake,
                                      color: currentSelection == 'Shape' ? Colors.red : Colors.white,
                                    ),
                                    Text(
                                      'Форма',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: currentSelection == 'Shape' ? Colors.red : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                _onSelectionChanged('Shape');
                              },
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 70,
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  color: currentSelection == 'Flavor' ? Colors.white : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.restaurant_menu,
                                      color: currentSelection == 'Flavor' ? Colors.red : Colors.white,
                                    ),
                                    Text(
                                      'Начинка',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: currentSelection == 'Flavor' ? Colors.red : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _controller.runJavaScript('''
                                document.getElementById('flavor').click(); 
                              ''');
                                });
                                _onSelectionChanged('Flavor');
                              },
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 70,
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  color: currentSelection == 'Colour' ? Colors.white : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.color_lens,
                                      color: currentSelection == 'Colour' ? Colors.red : Colors.white,
                                    ),
                                    Text(
                                      'Цвет',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: currentSelection == 'Colour' ? Colors.red : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _controller.runJavaScript('''
                                document.getElementById('colour').click(); 
                              ''');
                                });
                                _onSelectionChanged('Colour');
                              },
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 70,
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  color: currentSelection == 'Topping' ? Colors.white : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.style_sharp,
                                      color: currentSelection == 'Topping' ? Colors.red : Colors.white,
                                    ),
                                    Text(
                                      'Заказ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: currentSelection == 'Topping' ? Colors.red : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                _onSelectionChanged('Topping');
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _buildSelection(context),
                      ),
                    ],
                  ),
                )
              ],
            ));
      }),
    );
  }

  Widget _buildShapeSelection(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(9),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: Shape.values.length,
            itemBuilder: (context, index) {
              final shape = Shape.values[index];
              final isSelected = context.watch<CakeCustomizationBloc>().state.shape == shape;
              return InkWell(
                highlightColor: Colors.black,
                splashColor: Colors.black,
                onTap: () async {
                  context.read<CakeCustomizationBloc>().add(ShapeSelected(shape));
                  setState(() {
                    _controller.runJavaScript(shapeObj[shape]!);
                  });
                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFF6F6F6).withOpacity(0.9) : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: isSelected ? const Color(0xFFB71C1C) : const Color(0xF4DCC6C6),
                    ),
                  ),
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        shapeImg[shape]!,
                        height: 70,
                        width: 70,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        shapeName[shape]!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\₸${shapePrices[shape]!}',
                        style: const TextStyle(
                          color: Color(0xff4f4f4f),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFlavorSelection(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(9),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: Flavor.values.length,
        itemBuilder: (context, index) {
          final flavor = Flavor.values[index];
          final isSelected = context.watch<CakeCustomizationBloc>().state.flavor == flavor;
          return InkWell(
            highlightColor: Colors.black,
            splashColor: Colors.black,
            onTap: () {
              context.read<CakeCustomizationBloc>().add(FlavorSelected(flavor));
              setState(() {
                _controller.runJavaScript(flavorObj[flavor]!);
              });
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF6F6F6).withOpacity(0.9) : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: isSelected ? const Color(0xFFB71C1C) : const Color(0xF4DCC6C6),
                ),
              ),
              padding: const EdgeInsets.all(9.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    flavorImg[flavor]!,
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    flavorName[flavor]!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\₸${flavorPrices[flavor]!}',
                    style: const TextStyle(
                      color: Color(0xff4f4f4f),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildColourSelection(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(9),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: Colour.values.length,
        itemBuilder: (context, index) {
          final colour = Colour.values[index];
          final isSelected = context.watch<CakeCustomizationBloc>().state.colour == colour;
          return InkWell(
            highlightColor: Colors.black,
            splashColor: Colors.black,
            onTap: () {
              context.read<CakeCustomizationBloc>().add(ColourSelected(colour));
              setState(() {
                _controller.runJavaScript(colourObj[colour]!);
              });
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF6F6F6).withOpacity(0.9) : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: isSelected ? const Color(0xFFB71C1C) : const Color(0xF4DCC6C6),
                ),
              ),
              padding: const EdgeInsets.all(9.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    colourImg[colour]!,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    colourName[colour]!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class buildCustomSelection extends StatefulWidget {
  const buildCustomSelection({Key? key}) : super(key: key);

  @override
  State<buildCustomSelection> createState() => _buildCustomSelectionState();
}

class _buildCustomSelectionState extends State<buildCustomSelection> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      context.read<CakeCustomizationBloc>().add(ImagePicked(File(pickedFile.path)));
    }
  }

  void _removeImage() {
    print('Remove image event triggered');
    context.read<CakeCustomizationBloc>().add(ImageRemoved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CakeCustomizationBloc, CakeCustomizationState>(
      builder: (context, state) {
        print('Building UI with state: ${state.selectedImage}');
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: state.selectedImage == null || state.selectedImage?.path == ''
                    ? GestureDetector(
                        onTap: _pickImage,
                        child: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 2,
                          dashPattern: const [6, 6],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey),
                                  SizedBox(height: 10),
                                  Text(
                                    'Нажмите, чтобы выбрать изображение',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(state.selectedImage!, width: double.infinity, height: 200, fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                _removeImage();
                                print('Remove button tapped');
                              },
                              child: Container(
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    var apiProduct = Product('Кастомный торт', state.totalPrice, state.flavor.toString(), state.colour.toString(), state.shape.toString(),
                        'https://firebasestorage.-744c7.appspot.', 99, 'costume', '', state.selectedImage ?? File(''));
                    context.read<CartBloc>().add(AddProduct(apiProduct));
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Navbar(initialPageIndex: 1)),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Добавить в корзину'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
