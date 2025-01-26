import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/core/util/nil_protect.dart';
import 'package:process/features/cart/presentation/riverpod/cart_riverpod.dart';
import 'package:process/features/customize/presentation/bloc/customization_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget buildSelection(String currentSelection, WebViewController webViewController) {
  switch (currentSelection) {
    case 'Shape':
      return BuildShapeSelection(
        webViewController: webViewController,
      );
    case 'Flavor':
      return BuildFlavorSelection(
        webViewController: webViewController,
      );
    case 'Colour':
      return BuildColourSelection(
        webViewController: webViewController,
      );
    case 'Topping':
      return const BuildCustomSelection();
    default:
      return Container();
  }
}
//---------------------------------------------------------------------

//---------------------------------------------------------------------
class BuildShapeSelection extends StatefulWidget {
  const BuildShapeSelection({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  State<BuildShapeSelection> createState() => _BuildShapeSelectionState();
}

class _BuildShapeSelectionState extends State<BuildShapeSelection> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
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
        final isSelected = context.watch<CustomizationBloc>().state.shape == shape;
        return InkWell(
          highlightColor: Colors.black,
          splashColor: Colors.black,
          onTap: () {
            context.read<CustomizationBloc>().add(ShapeSelected(shape));
            widget.webViewController.runJavaScript(shapeObj[shape]!);
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
                  '₸${shapePrices[shape]!}',
                  style: const TextStyle(
                    color: Color(0xff4f4f4f),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
//---------------------------------------------------------------------

//---------------------------------------------------------------------
class BuildFlavorSelection extends StatefulWidget {
  const BuildFlavorSelection({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  State<BuildFlavorSelection> createState() => _BuildFlavorSelectionState();
}

class _BuildFlavorSelectionState extends State<BuildFlavorSelection> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
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
        final isSelected = context.watch<CustomizationBloc>().state.flavor == flavor;
        return InkWell(
          highlightColor: Colors.black,
          splashColor: Colors.black,
          onTap: () {
            context.read<CustomizationBloc>().add(FlavorSelected(flavor));
            setState(() {
              widget.webViewController.runJavaScript(flavorObj[flavor]!);
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
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₸${flavorPrices[flavor]!}',
                  style: const TextStyle(
                    color: Color(0xff4f4f4f),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
//---------------------------------------------------------------------

//---------------------------------------------------------------------
class BuildColourSelection extends StatefulWidget {
  const BuildColourSelection({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  State<BuildColourSelection> createState() => _BuildColourSelectionState();
}

class _BuildColourSelectionState extends State<BuildColourSelection> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
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
        final isSelected = context.watch<CustomizationBloc>().state.colour == colour;
        return InkWell(
          highlightColor: Colors.black,
          splashColor: Colors.black,
          onTap: () {
            context.read<CustomizationBloc>().add(ColourSelected(colour));
            setState(() {
              widget.webViewController.runJavaScript(colourObj[colour]!);
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
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
//---------------------------------------------------------------------

//---------------------------------------------------------------------
class BuildCustomSelection extends StatefulWidget {
  const BuildCustomSelection({super.key});

  @override
  State<BuildCustomSelection> createState() => _BuildCustomSelectionState();
}

class _BuildCustomSelectionState extends State<BuildCustomSelection> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      context.read<CustomizationBloc>().add(ImagePicked(File(pickedFile.path)));
    }
  }

  void _removeImage() {
    context.read<CustomizationBloc>().add(ImageRemoved());
  }

  int generateProductId(Shape shape, Colour colour, Flavor flavor) {
    final uniqueString = '${shape.name}_${colour.name}_${flavor.name}';
    return uniqueString.hashCode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomizationBloc, CustomizationState>(
      builder: (context, state) {
        return Column(
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
                        child: const SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Center(
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
                            onTap: _removeImage,
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
              padding: EdgeInsets.all(10),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final cartRiverpod = ref.read(cartProvider.notifier);

                  return ElevatedButton(
                    onPressed: () {
                      final productId = generateProductId(state.shape, state.colour, state.flavor);

                      CartProduct cartProduct = CartProduct(
                        category: nilProtect.string,
                        name: nilProtect.string,
                        product_id: productId,
                        quantity: 1,
                        slug: nilProtect.string,
                        price: state.totalPrice,
                        shape: state.shape.toString(),
                        colour: state.colour.toString(),
                        flavor: state.flavor.toString(),
                        imageUrl: nilProtect.imageUrl,
                      );

                      try {
                        cartRiverpod.addCartProduct(cartProduct);
                        router.pop();
                      } catch (e) {
                        logger.e('e: $e');
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Добавить в корзину'),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
