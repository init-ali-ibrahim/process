import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// Event
abstract class DoneCustomizationEvent extends Equatable {
  const DoneCustomizationEvent();

  @override
  List<Object> get props => [];
}

class ShapeSelected extends DoneCustomizationEvent {
  final Shape shape;

  const ShapeSelected(this.shape);

  @override
  List<Object> get props => [shape];
}

class FlavorSelected extends DoneCustomizationEvent {
  final Flavor flavor;

  const FlavorSelected(this.flavor);

  @override
  List<Object> get props => [flavor];
}

class ColourSelected extends DoneCustomizationEvent {
  final Colour colour;

  const ColourSelected(this.colour);

  @override
  List<Object> get props => [colour];
}

// State
enum Shape { MiniStandard, MiniHeart, StandardDone, HeartDone }

enum Flavor { Vanilla, ChocoCrunch, RedVelvet, Nutella }

enum Colour { Red, Blue, Yellow, Green }

class DoneCustomizationState extends Equatable {
  final Shape shape;
  final Flavor flavor;
  final Colour colour;

  final String imagePath;
  final bool isLoadingImage;

  final double totalPrice;

  final String shapeImagePath;
  final String flavorImagePath;
  final String colourImagePath;

  final String shapeName;
  final String flavorName;
  final String colourName;

  const DoneCustomizationState({
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

  DoneCustomizationState copyWith({
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
    return DoneCustomizationState(
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
    );
  }

  @override
  List<Object> get props =>
      [shape, flavor, colour, imagePath, totalPrice, isLoadingImage, shapeImagePath, flavorImagePath, colourImagePath, shapeName, flavorName, colourName];
}

// Bloc
class DoneCustomizationBloc extends Bloc<DoneCustomizationEvent, DoneCustomizationState> {
  DoneCustomizationBloc()
      : super(
    DoneCustomizationState(
      shape: Shape.MiniStandard,
      flavor: Flavor.Vanilla,
      colour: Colour.Red,
      imagePath: 'assets/Dones/ministandard_vanilla.png',
      totalPrice: _calculateInitialTotalPrice(),
      isLoadingImage: true,
      shapeImagePath: '',
      flavorImagePath: '',
      colourImagePath: '',
      shapeName: '',
      flavorName: '',
      colourName: '',
    ),
  ) {
    on<ShapeSelected>(_onShapeSelected);
    on<FlavorSelected>(_onFlavorSelected);
    on<ColourSelected>(_onColourSelected);
  }

  static double _calculateInitialTotalPrice() {
    return shapePrices[Shape.MiniStandard]! + flavorPrices[Flavor.Vanilla]! + colourPrices[Colour.Red]!;
  }

  double _calculateTotalPrice(Shape shape, Flavor flavor, Colour colour) {
    return shapePrices[shape]! + flavorPrices[flavor]! + colourPrices[colour]!;
  }

  void _onShapeSelected(ShapeSelected event, Emitter<DoneCustomizationState> emit) {
    emit(state.copyWith(shape: event.shape, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(event.shape, state.flavor, state.colour)));
    _getImagePath(event.shape, state.flavor, state.colour).then((imagePath) {
      emit(state.copyWith(
        imagePath: imagePath,
        isLoadingImage: false,
      ));
    }).catchError((error) {});
  }

  void _onFlavorSelected(FlavorSelected event, Emitter<DoneCustomizationState> emit) {
    emit(state.copyWith(flavor: event.flavor, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, event.flavor, state.colour)));
    _getImagePath(state.shape, event.flavor, state.colour).then((imagePath) {
      emit(state.copyWith(
        imagePath: imagePath,
        isLoadingImage: false,
      ));
    }).catchError((error) {});
  }

  void _onColourSelected(ColourSelected event, Emitter<DoneCustomizationState> emit) {
    emit(state.copyWith(colour: event.colour, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, state.flavor, event.colour)));
    _getImagePath(state.shape, state.flavor, event.colour).then((imagePath) {
      emit(state.copyWith(
        imagePath: imagePath,
        isLoadingImage: false,
      ));
    }).catchError((error) {});
  }

  Future<String> _getImagePath(Shape shape, Flavor flavor, Colour colour) {
    String shapeString = shape.toString().split('.').last.toLowerCase();
    String flavorString = flavor.toString().split('.').last.toLowerCase();
    String colourString = colour.toString().split('.').last.toLowerCase();
    Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('Cakes/$shapeString\_$flavorString\_$colourString.png');
    Future<String> downloadURL = ref.getDownloadURL();
    return downloadURL;
  }
}

// Total Price
const Map<Shape, double> shapePrices = {
  Shape.MiniStandard: 20.0,
  Shape.MiniHeart: 10.0,
  Shape.StandardDone: 30.0,
  Shape.HeartDone: 25.0,
};
const Map<Flavor, double> flavorPrices = {
  Flavor.Vanilla: 2.0,
  Flavor.ChocoCrunch: 3.5,
  Flavor.RedVelvet: 4.0,
  Flavor.Nutella: 5.0,
};
const Map<Colour, double> colourPrices = {
  Colour.Red: 0.0,
  Colour.Yellow: 1.0,
  Colour.Blue: 1.5,
  Colour.Green: 1.5,
};

const Map<Shape, String> shapeImg = {
  Shape.MiniStandard: 'assets/fill/ministandard.png',
  Shape.MiniHeart: 'assets/fill/miniheart.png',
  Shape.StandardDone: 'assets/fill/standardDone.png',
  Shape.HeartDone: 'assets/fill/heartDone.png',
};
const Map<Flavor, String> flavorImg = {
  Flavor.Vanilla: 'assets/taste/vanilla.png',
  Flavor.ChocoCrunch: 'assets/taste/chococrunch.png',
  Flavor.RedVelvet: 'assets/taste/redvelvet.png',
  Flavor.Nutella: 'assets/taste/nutella.png',
};
const Map<Colour, String> colourImg = {
  Colour.Red: 'assets/color/red.png',
  Colour.Yellow: 'assets/color/yellow.png',
  Colour.Blue: 'assets/color/blue.png',
  Colour.Green: 'assets/color/green.png',
};

const Map<Shape, String> shapeName = {
  Shape.MiniStandard: 'Мини стандарт',
  Shape.MiniHeart: 'Мини сердце',
  Shape.StandardDone: 'Стандарт торт',
  Shape.HeartDone: 'Стандарт сердце',
};
const Map<Flavor, String> flavorName = {
  Flavor.Vanilla: 'ваниль',
  Flavor.ChocoCrunch: 'чокоранч',
  Flavor.RedVelvet: 'красный велвет',
  Flavor.Nutella: 'нателла',
};
const Map<Colour, String> colourName = {
  Colour.Red: 'красный',
  Colour.Yellow: 'желтый',
  Colour.Blue: 'синий',
  Colour.Green: 'зеленый',
};

// UI
class DoneCustomizationScreen extends StatefulWidget {
  @override
  State<DoneCustomizationScreen> createState() => _DoneCustomizationScreenState();
}

class _DoneCustomizationScreenState extends State<DoneCustomizationScreen> {

  Future<String> _getImagePath(Shape shape, Flavor flavor, Colour colour) async {
    String shapeString = shape.toString().split('.').last.toLowerCase();
    String flavorString = flavor.toString().split('.').last.toLowerCase();
    String colorString = colour.toString().split('.').last.toLowerCase();
    Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('Dones/$shapeString\_$flavorString\_$colorString.png');
    Future<String> downloadURL = ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoneCustomizationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          actions: [
            BlocBuilder<DoneCustomizationBloc, DoneCustomizationState>(builder: (context, state) {
              return Text(
                'Total Price: \$${state.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              );
            }),
            const SizedBox(width: 20)
          ],
        ),
        body: BlocBuilder<DoneCustomizationBloc, DoneCustomizationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<String>(
                    future: _getImagePath(state.shape, state.flavor, state.colour),
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
                    },
                  ),
                  const SizedBox(height: 20),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Shape:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  _buildShapeSelection(context),
                  const SizedBox(height: 20),
                  // const Text('flavor:', style: TextStyle(fontSize: 18)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Flavor:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),

                  _buildFlavorSelection(context),
                  const SizedBox(height: 20),
                  // const Text('color:', style: TextStyle(fontSize: 18)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Color:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  _buildColourSelection(context),
                  const SizedBox(height: 20),
                  // Text('${state.imagePath}'),
                  const Text('dawta'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShapeSelection(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Shape.values.length,
        itemBuilder: (context, index) {
          final shape = Shape.values[index];
          return InkWell(
              onTap: () => context.read<DoneCustomizationBloc>().add(ShapeSelected(shape)),
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8),
                decoration:
                BoxDecoration(color: const Color(0xA8F1E2E3), borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: const Color(0xF4CCADAD))),
                child: Column(
                  children: [
                    Image.asset(
                      '${shapeImg[shape]}',
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      '${shapeName[shape]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$${shapePrices[shape]!.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xff4f4f4f))),
                    // Text('${shapeImg[shape]}'),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget _buildFlavorSelection(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Flavor.values.length,
        itemBuilder: (context, index) {
          final flavor = Flavor.values[index];
          return InkWell(
              onTap: () => context.read<DoneCustomizationBloc>().add(FlavorSelected(flavor)),
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8),
                decoration:
                BoxDecoration(color: const Color(0xA8F1E2E3), borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: const Color(0xF4CCADAD))),
                child: Column(
                  children: [
                    Image.asset(
                      '${flavorImg[flavor]}',
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      '${flavorName[flavor]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$${flavorPrices[flavor]!.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xff4f4f4f))),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget _buildColourSelection(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Colour.values.length,
        itemBuilder: (context, index) {
          final colour = Colour.values[index];
          return InkWell(
              onTap: () => context.read<DoneCustomizationBloc>().add(ColourSelected(colour)),
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8),
                decoration:
                BoxDecoration(color: const Color(0xA8F1E2E3), borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: const Color(0xF4CCADAD))),
                child: Column(
                  children: [
                    Image.asset(
                      '${colourImg[colour]}',
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      '${colourName[colour]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$${colourPrices[colour]!.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xff4f4f4f))),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
