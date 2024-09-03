import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:process/screens/cake_create/bloc/cake_customization_bloc.dart';
import 'package:process/screens/cart/bloc/cart_bloc.dart';
import 'package:process/screens/cart/cart_screen.dart';
import 'package:process/screens/navbar.dart';

const Map<Shape, double> shapePrices = {
  Shape.MiniStandard: 20.0,
  Shape.MiniHeart: 10.0,
  Shape.StandardCake: 30.0,
  Shape.HeartCake: 25.0,
  Shape.SheetCake: 5.0,
  Shape.SquareCake: 5.0
};
const Map<Flavor, double> flavorPrices = {
  Flavor.Vanilla: 2.0,
  Flavor.ChocoCrunch: 3.5,
  Flavor.RedVelvet: 4.0,
  Flavor.Nutella: 5.0,
  Flavor.Fruits: 5.0,
  Flavor.Cinnamon: 5.0,
  Flavor.Pistachio: 0.0,
};
const Map<Colour, double> colourPrices = {
  Colour.Red: 0.0,
  Colour.Yellow: 1.0,
  Colour.Blue: 1.5,
  Colour.Green: 1.5,
  Colour.Brown: 1.0,
  Colour.White: 1.0,
  Colour.Orange: 0.0,
  Colour.DarkBlue: 0.0,
  Colour.LightBlue: 0.0,
  Colour.Pink: 0,
  Colour.Purple: 0,
  Colour.DarkGreen: 0,
};
const Map<Topping, double> toppingPrices = {
  Topping.None: 0.0,
  Topping.Classic: 0.0,
  Topping.Christmas: 1.0,
  Topping.Snow: 1.5,
};

const Map<Shape, String> shapeImg = {
  Shape.MiniStandard: 'assets/image/fill/ministandard.png',
  Shape.MiniHeart: 'assets/image/fill/miniheart.png',
  Shape.StandardCake: 'assets/image/fill/standardcake.png',
  Shape.HeartCake: 'assets/image/fill/heartcake.png',
  Shape.SquareCake: 'assets/image/fill/squarecake.png',
  Shape.SheetCake: 'assets/image/fill/sheetcake.png'
};
const Map<Flavor, String> flavorImg = {
  Flavor.Vanilla: 'assets/image/taste/vanilla.png',
  Flavor.ChocoCrunch: 'assets/image/taste/chococrunch.png',
  Flavor.RedVelvet: 'assets/image/taste/redvelvet.png',
  Flavor.Nutella: 'assets/image/taste/nutella.png',
  Flavor.Pistachio: 'assets/image/taste/pistachio.png',
  Flavor.Cinnamon: 'assets/image/taste/cinnamon.png',
  Flavor.Fruits: 'assets/image/taste/fruits.png'
};
const Map<Colour, String> colourImg = {
  Colour.Red: 'assets/image/color/red.png',
  Colour.Yellow: 'assets/image/color/yellow.png',
  Colour.Blue: 'assets/image/color/blue.png',
  Colour.Green: 'assets/image/color/green.png',
  Colour.Brown: 'assets/image/color/brown.png',
  Colour.White: 'assets/image/color/white.png',
  Colour.Orange: 'assets/image/color/orange.png',
  Colour.DarkBlue: 'assets/image/color/darkblue.png',
  Colour.LightBlue: 'assets/image/color/whiteblue.png',
  Colour.Pink: 'assets/image/color/pink.png',
  Colour.Purple: 'assets/image/color/purple.png',
  Colour.DarkGreen: 'assets/image/color/darkgreen.png',
};
const Map<Topping, String> toppingImg = {
  Topping.Snow: 'assets/image/topping/christmas.png',
  Topping.Christmas: 'assets/image/topping/classic.png',
  Topping.Classic: 'assets/image/topping/snow.png',
  Topping.None: 'assets/image/topping/none.png',
};

const Map<Shape, String> shapeName = {
  Shape.MiniStandard: 'Мини стандарт',
  Shape.MiniHeart: 'Мини сердце',
  Shape.StandardCake: 'Стандарт торт',
  Shape.HeartCake: 'Cердце',
  Shape.SquareCake: 'SquareCake',
  Shape.SheetCake: 'SheetCake',
};
const Map<Flavor, String> flavorName = {
  Flavor.Vanilla: 'ваниль',
  Flavor.ChocoCrunch: 'чокоранч',
  Flavor.RedVelvet: 'красный велвет',
  Flavor.Nutella: 'нателла',
  Flavor.Pistachio: 'Pistachio',
  Flavor.Cinnamon: 'Cinnamon',
  Flavor.Fruits: 'Fruits'
};
const Map<Colour, String> colourName = {
  Colour.Red: 'красный',
  Colour.Yellow: 'желтый',
  Colour.Blue: 'синий',
  Colour.Green: 'зеленый',
  Colour.Brown: 'Brown',
  Colour.White: 'White',
  Colour.Orange: 'Orange',
  Colour.DarkBlue: 'DarkBlue',
  Colour.LightBlue: 'LightBlue',
  Colour.Pink: 'Pink',
  Colour.Purple: 'Purple',
  Colour.DarkGreen: 'DarkGreen',
};
const Map<Topping, String> toppingName = {
  Topping.Snow: 'snow',
  Topping.Christmas: 'christmas',
  Topping.Classic: 'classic',
  Topping.None: 'none',
};

// UI
class CakeCustomizationScreen extends StatefulWidget {
  const CakeCustomizationScreen({super.key});

  @override
  State<CakeCustomizationScreen> createState() => _CakeCustomizationScreenState();
}

class _CakeCustomizationScreenState extends State<CakeCustomizationScreen> {
  Future<String> _getImagePath(Shape shape, Flavor flavor, Colour colour, Topping topping) async {
    String shapeString = shape.toString().split('.').last.toLowerCase();
    String flavorString = flavor.toString().split('.').last.toLowerCase();
    String colorString = colour.toString().split('.').last.toLowerCase();
    String toppingString = topping.toString().split('.').last.toLowerCase();
    Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('cakes/$shapeString\_$flavorString\_$colorString\_$toppingString.png');
    Future<String> downloadURL = ref.getDownloadURL();
    return downloadURL;
  }

  String currentSelection = 'Shape';

  void _onSelectionChanged(String selection) {
    setState(() {
      currentSelection = selection;
    });
  }

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
        // return _buildToppingSelection(context);
        return _buildCustomSelection(context);
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
                'сумма: \₸${state.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 20)
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FutureBuilder<String>(
                      future: _getImagePath(state.shape, state.flavor, state.colour, state.topping),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            height: 200,
                            child: Text('${snapshot.data.toString()}'),
                          );
                        } else if (snapshot.hasData) {
                          return Image.network(snapshot.data!, height: 200);
                        } else {
                          return const SizedBox.shrink();
                        }
                      })),
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
                      // Длительность анимации
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
                              // Длительность анимации
                              width: 70,
                              padding: const EdgeInsets.all(10),
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
                                    'Shape',
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
                              // Длительность анимации
                              width: 70,
                              padding: const EdgeInsets.all(10),
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
                                    'Flavor',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: currentSelection == 'Flavor' ? Colors.red : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              _onSelectionChanged('Flavor');
                            },
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              // Длительность анимации
                              width: 70,
                              padding: const EdgeInsets.all(10),
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
                                    'Colour',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: currentSelection == 'Colour' ? Colors.red : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              _onSelectionChanged('Colour');
                            },
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              // Длительность анимации
                              width: 70,
                              padding: const EdgeInsets.all(10),
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
                                    'Topping',
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
          ),
        );
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
                onTap: () {
                  context.read<CakeCustomizationBloc>().add(ShapeSelected(shape));
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
                        '\₸${shapePrices[shape]!.toStringAsFixed(2)}',
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
                    '\₸${flavorPrices[flavor]!.toStringAsFixed(2)}',
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

  Widget _buildCustomSelection(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CakeCustomizationBloc, CakeCustomizationState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () async {
              String urlToCart = await _getImagePath(state.shape, state.flavor, state.colour, state.topping);
              // print('Shape: ${state.shape.toString()}');
              // print('Flavor: ${state.flavor.toString()}');
              // print('Colour: ${state.colour.toString()}');
              // print('TotalPrice: ${state.totalPrice}');
              // print('URL to Cart: $urlToCart');

              var lox = Product(
                state.shape.toString(),
                state.totalPrice,
                state.flavor.toString(),
                state.colour.toString(),
                state.shape.toString(),
                urlToCart,
              );

              context.read<CartBloc>().add(AddProduct(lox));

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Navbar(initialPageIndex: 1)),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Добавить в корзину'),
          );
        },
      ),
    );
  }
}
