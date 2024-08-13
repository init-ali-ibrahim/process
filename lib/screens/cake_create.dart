import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:process/screens/cartTest.dart';

// Event
abstract class CakeCustomizationEvent extends Equatable {
  const CakeCustomizationEvent();

  @override
  List<Object> get props => [];
}

class ShapeSelected extends CakeCustomizationEvent {
  final Shape shape;

  const ShapeSelected(this.shape);

  @override
  List<Object> get props => [shape];
}

class FlavorSelected extends CakeCustomizationEvent {
  final Flavor flavor;

  const FlavorSelected(this.flavor);

  @override
  List<Object> get props => [flavor];
}

class ColourSelected extends CakeCustomizationEvent {
  final Colour colour;

  const ColourSelected(this.colour);

  @override
  List<Object> get props => [colour];
}

class ToppingSelected extends CakeCustomizationEvent {
  final Topping topping;

  const ToppingSelected(this.topping);

  @override
  List<Object> get props => [topping];
}

// State
enum Shape { MiniStandard, MiniHeart, StandardCake, HeartCake, SquareCake, SheetCake }

enum Flavor { Vanilla, ChocoCrunch, RedVelvet, Nutella, Fruits, Cinnamon, Pistachio }

enum Colour { Yellow, Red, Blue, Green, White, Brown, Pink, Purple, Orange, LightBlue, DarkBlue, DarkGreen }

enum Topping { None, Snow, Christmas, Classic }

class CakeCustomizationState extends Equatable {
  final Shape shape;
  final Flavor flavor;
  final Colour colour;
  final Topping topping;

  final String imagePath;
  final bool isLoadingImage;
  final double totalPrice;

  final String shapeImagePath;
  final String flavorImagePath;
  final String colourImagePath;
  final String toppingImagePath;

  final String shapeName;
  final String flavorName;
  final String colourName;
  final String toppingName;

  const CakeCustomizationState({
    required this.topping,
    required this.toppingName,
    required this.toppingImagePath,
    required this.shape,
    required this.flavor,
    required this.colour,
    required this.imagePath,
    required this.totalPrice,
    required this.isLoadingImage,
    required this.shapeImagePath,
    required this.flavorImagePath,
    required this.colourImagePath,
    required this.shapeName,
    required this.flavorName,
    required this.colourName,
  });

  CakeCustomizationState copyWith({
    Topping? topping,
    String? toppingName,
    String? toppingImagePath,
    Shape? shape,
    Flavor? flavor,
    Colour? colour,
    String? imagePath,
    double? totalPrice,
    bool? isLoadingImage,
    String? shapeImagePath,
    String? flavorImagePath,
    String? colourImagePath,
    String? shapeName,
    String? flavorName,
    String? colourName,
  }) {
    return CakeCustomizationState(
      shape: shape ?? this.shape,
      flavor: flavor ?? this.flavor,
      colour: colour ?? this.colour,
      imagePath: imagePath ?? this.imagePath,
      totalPrice: totalPrice ?? this.totalPrice,
      isLoadingImage: isLoadingImage ?? this.isLoadingImage,
      shapeImagePath: shapeImagePath ?? this.shapeImagePath,
      flavorImagePath: flavorImagePath ?? this.flavorImagePath,
      colourImagePath: colourImagePath ?? this.colourImagePath,
      shapeName: shapeName ?? this.shapeName,
      flavorName: flavorName ?? this.flavorName,
      colourName: colourName ?? this.colourName,
      topping: topping ?? this.topping,
      toppingImagePath: toppingImagePath ?? this.toppingImagePath,
      toppingName: toppingName ?? this.toppingName,
    );
  }

  @override
  List<Object> get props => [
        shape,
        flavor,
        colour,
        imagePath,
        totalPrice,
        isLoadingImage,
        shapeImagePath,
        flavorImagePath,
        colourImagePath,
        shapeName,
        flavorName,
        colourName,
        topping,
        toppingName,
        toppingImagePath
      ];
}

// Bloc
class CakeCustomizationBloc extends Bloc<CakeCustomizationEvent, CakeCustomizationState> {
  CakeCustomizationBloc()
      : super(
          CakeCustomizationState(
            shape: Shape.MiniStandard,
            flavor: Flavor.Vanilla,
            colour: Colour.Yellow,
            topping: Topping.None,
            imagePath: '',
            totalPrice: _calculateInitialTotalPrice(),
            isLoadingImage: true,
            shapeImagePath: '',
            flavorImagePath: '',
            colourImagePath: '',
            toppingImagePath: '',
            shapeName: '',
            flavorName: '',
            colourName: '',
            toppingName: '',
          ),
        ) {
    on<ShapeSelected>(_onShapeSelected);
    on<FlavorSelected>(_onFlavorSelected);
    on<ColourSelected>(_onColourSelected);
    on<ToppingSelected>(_onToppingSelected);
  }

  static double _calculateInitialTotalPrice() {
    return shapePrices[Shape.MiniStandard]! + flavorPrices[Flavor.Vanilla]! + colourPrices[Colour.Red]! + toppingPrices[Topping.Classic]!;
  }

  double _calculateTotalPrice(Shape shape, Flavor flavor, Colour colour, Topping topping) {
    return shapePrices[shape]! + flavorPrices[flavor]! + colourPrices[colour]! + toppingPrices[topping]!;
  }

  void _onShapeSelected(ShapeSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
        shape: event.shape, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(event.shape, state.flavor, state.colour, state.topping)));
    _getImagePath(event.shape, state.flavor, state.colour, state.topping).then((imagePath) {
      emit(state.copyWith(
        imagePath: imagePath,
        isLoadingImage: false,
      ));
    }).catchError((error) {});
  }

  void _onFlavorSelected(FlavorSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
        flavor: event.flavor, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, event.flavor, state.colour, state.topping)));
    _getImagePath(state.shape, event.flavor, state.colour, state.topping).then((imagePath) {
      emit(state.copyWith(
        imagePath: imagePath,
        isLoadingImage: false,
      ));
    }).catchError((error) {});
  }

  void _onColourSelected(ColourSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
        colour: event.colour, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, state.flavor, event.colour, state.topping)));
    _getImagePath(state.shape, state.flavor, event.colour, state.topping).then((imagePath) {
      emit(state.copyWith(
        imagePath: imagePath,
        isLoadingImage: false,
      ));
    }).catchError((error) {});
  }

  void _onToppingSelected(ToppingSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
        topping: event.topping, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, state.flavor, state.colour, event.topping)));
    _getImagePath(state.shape, state.flavor, state.colour, event.topping).then((imagePath) {
      emit(state.copyWith(
        imagePath: imagePath,
        isLoadingImage: false,
      ));
    }).catchError((error) {});
  }

  Future<String> _getImagePath(Shape shape, Flavor flavor, Colour colour, Topping topping) {
    String shapeString = shape.toString().split('.').last.toLowerCase();
    String flavorString = flavor.toString().split('.').last.toLowerCase();
    String colourString = colour.toString().split('.').last.toLowerCase();
    String toppingString = topping.toString().split('.').last.toLowerCase();
    Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('cakes/$shapeString\_$flavorString\_$colourString\_$toppingString.png');
    Future<String> downloadURL = ref.getDownloadURL();
    return downloadURL;
  }
}

// Total Price
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
  Shape.MiniStandard: 'assets/fill/ministandard.png',
  Shape.MiniHeart: 'assets/fill/miniheart.png',
  Shape.StandardCake: 'assets/fill/standardcake.png',
  Shape.HeartCake: 'assets/fill/heartcake.png',
  Shape.SquareCake: 'assets/fill/squarecake.png',
  Shape.SheetCake: 'assets/fill/sheetcake.png'
};
const Map<Flavor, String> flavorImg = {
  Flavor.Vanilla: 'assets/taste/vanilla.png',
  Flavor.ChocoCrunch: 'assets/taste/chococrunch.png',
  Flavor.RedVelvet: 'assets/taste/redvelvet.png',
  Flavor.Nutella: 'assets/taste/nutella.png',
  Flavor.Pistachio: 'assets/taste/pistachio.png',
  Flavor.Cinnamon: 'assets/taste/cinnamon.png',
  Flavor.Fruits: 'assets/taste/fruits.png'
};
const Map<Colour, String> colourImg = {
  Colour.Red: 'assets/color/red.png',
  Colour.Yellow: 'assets/color/yellow.png',
  Colour.Blue: 'assets/color/blue.png',
  Colour.Green: 'assets/color/green.png',
  Colour.Brown: 'assets/color/brown.png',
  Colour.White: 'assets/color/white.png',
  Colour.Orange: 'assets/color/orange.png',
  Colour.DarkBlue: 'assets/color/darkblue.png',
  Colour.LightBlue: 'assets/color/whiteblue.png',
  Colour.Pink: 'assets/color/pink.png',
  Colour.Purple: 'assets/color/purple.png',
  Colour.DarkGreen: 'assets/color/darkgreen.png',
};
const Map<Topping, String> toppingImg = {
  Topping.Snow: 'assets/topping/christmas.png',
  Topping.Christmas: 'assets/topping/classic.png',
  Topping.Classic: 'assets/topping/snow.png',
  Topping.None: 'assets/topping/none.png',
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
        return _buildToppingSelection(context);
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
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return alertClose(dialogContext);
                    },
                  );
                },
                icon: const Icon(Icons.close)),
            title: const Text('Кастомизация'),
            actions: [
              Text(
                'Total Price: \₸${state.totalPrice.toStringAsFixed(2)}',
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
                    Container(
                      decoration: BoxDecoration(color: Colors.red.shade200, borderRadius: const BorderRadius.only(topRight: Radius.circular(10))),
                      margin: const EdgeInsets.only(top: 10),
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          InkWell(
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: currentSelection == 'Shape' ? Colors.white : Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.cake,
                                    color: currentSelection == 'Shape' ? Colors.red.shade200 : Colors.white,
                                  ),
                                  Text(
                                    'Shape',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: currentSelection == 'Shape' ? Colors.red.shade200 : Colors.white,
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
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: currentSelection == 'Flavor' ? Colors.white : Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.restaurant_menu,
                                    color: currentSelection == 'Flavor' ? Colors.red.shade200 : Colors.white,
                                  ),
                                  Text(
                                    'Flavor',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: currentSelection == 'Flavor' ? Colors.red.shade200 : Colors.white,
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
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: currentSelection == 'Colour' ? Colors.white : Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.color_lens,
                                    color: currentSelection == 'Colour' ? Colors.red.shade200 : Colors.white,
                                  ),
                                  Text(
                                    'Colour',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: currentSelection == 'Colour' ? Colors.red.shade200 : Colors.white,
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
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: currentSelection == 'Topping' ? Colors.white : Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.style_sharp,
                                    color: currentSelection == 'Topping' ? Colors.red.shade200 : Colors.white,
                                  ),
                                  Text(
                                    'Topping',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: currentSelection == 'Topping' ? Colors.red.shade200 : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              _onSelectionChanged('Topping');
                            },
                          ),
                          // IconButton(
                          //   onPressed: () => _onSelectionChanged('Shape'),
                          //   icon: const Icon(Icons.cake),
                          //   color: currentSelection == 'Shape' ? Colors.purple : Colors.grey,
                          // ),
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

  Widget alertClose(BuildContext dialogContext) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      backgroundColor: Colors.white,
      title: const Text(
        'Очистить торт',
        style: TextStyle(fontSize: 20),
      ),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Ваш кастомный торт будет очищен',
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
          onPressed: () {
            Navigator.of(dialogContext).pop();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    );
  }

  Widget _buildShapeSelection(BuildContext context) {
    return Expanded(
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
                // color: Colors.white.withOpacity(0.9),
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

                  // Colour { money }
                  // const SizedBox(height: 4),
                  // Text(
                  //   '\₸${colourPrices[colour]!.toStringAsFixed(2)}',
                  //   style: const TextStyle(
                  //     color: Color(0xff4f4f4f),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToppingSelection(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(9),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: Topping.values.length,
        itemBuilder: (context, index) {
          final topping = Topping.values[index];
          final isSelected = context.watch<CakeCustomizationBloc>().state.topping == topping;
          return InkWell(
            highlightColor: Colors.black,
            splashColor: Colors.black,
            onTap: () {
              context.read<CakeCustomizationBloc>().add(ToppingSelected(topping));
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.9),
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
                    toppingImg[topping]!,
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    toppingName[topping]!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\₸${toppingPrices[topping]!.toStringAsFixed(2)}',
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
}
