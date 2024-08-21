part of 'cake_customization_bloc.dart';

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
