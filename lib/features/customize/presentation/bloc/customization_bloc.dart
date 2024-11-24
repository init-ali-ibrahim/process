import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:equatable/equatable.dart';

part 'customization_event.dart';
part 'customization_state.dart';

class CustomizationBloc extends Bloc<CustomizationEvent, CustomizationState> {
  CustomizationBloc()
      : super(
    CustomizationState(
      selectedImage: null,
      shape: Shape.MiniHeart,
      flavor: Flavor.RedVelvet,
      colour: Colour.White,
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
    on<ImagePicked>(_onImagePicked);
    on<ImageRemoved>(_onImageRemoved);
  }

  static int _calculateInitialTotalPrice() {
    return shapePrices[Shape.MiniStandard]! + flavorPrices[Flavor.Vanilla]! + colourPrices[Colour.Red]! + toppingPrices[Topping.Classic]!;
  }

  int _calculateTotalPrice(Shape shape, Flavor flavor, Colour colour, Topping topping) {
    return shapePrices[shape]! + flavorPrices[flavor]! + colourPrices[colour]! + toppingPrices[topping]!;
  }

  void _onShapeSelected(ShapeSelected event, Emitter<CustomizationState> emit) {
    emit(state.copyWith(
        shape: event.shape, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(event.shape, state.flavor, state.colour, state.topping)));
  }

  void _onFlavorSelected(FlavorSelected event, Emitter<CustomizationState> emit) {
    emit(state.copyWith(
        flavor: event.flavor, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, event.flavor, state.colour, state.topping)));
  }

  void _onColourSelected(ColourSelected event, Emitter<CustomizationState> emit) {
    emit(state.copyWith(
        colour: event.colour, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, state.flavor, event.colour, state.topping)));
  }

  void _onToppingSelected(ToppingSelected event, Emitter<CustomizationState> emit) {
    emit(state.copyWith(
        topping: event.topping, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, state.flavor, state.colour, event.topping)));
  }

  void _onImagePicked(ImagePicked event, Emitter<CustomizationState> emit) {
    emit(state.copyWith(
      selectedImage: event.imageFile,
      imagePath: event.imageFile.path,
      isLoadingImage: false,
    ));
  }

  void _onImageRemoved(ImageRemoved event, Emitter<CustomizationState> emit) {
    print('DAAAAAAAAAAAAAA');
    emit(state.copyWith(selectedImage: File('')));
  }

}

// ---

const Map<Shape, String> shapeObj = {
  Shape.MiniStandard: '''
          document.getElementById('root/circle.glb').click(); 
        ''',
  Shape.MiniHeart: '''
          document.getElementById('root/heart.glb').click(); 
        ''',
  Shape.StandardCake: '''
          document.getElementById('root/h-circle.glb').click(); 
        ''',
  Shape.HeartCake: '''
          document.getElementById('root/heart.glb').click(); 
        ''',
  Shape.SquareCake: '''
          document.getElementById('root/square.glb').click(); 
        ''',
  Shape.SheetCake: '''
          document.getElementById('root/rect.glb').click(); 
        '''
};

const Map<Flavor, String> flavorObj = {
  Flavor.Vanilla: '''
          document.getElementById('vanilla/side.jpg').click(); 
        ''',
  Flavor.ChocoCrunch: '''
          document.getElementById('choco/side.jpg').click(); 
        ''',
  Flavor.RedVelvet: '''
          document.getElementById('red-v/side.jpg').click(); 
        ''',
  Flavor.Nutella: '''
          document.getElementById('nutella/side.jpg').click(); 
        ''',
  Flavor.Fruits: '''
          document.getElementById('fruits/side.jpg').click(); 
        ''',
  Flavor.Cinnamon: '''
          document.getElementById('cinnamon/side.jpg').click(); 
        ''',
  Flavor.Pistachio: '''
          document.getElementById('pistachio/side.jpg').click(); 
        ''',
};

const Map<Colour, String> colourObj = {
  Colour.Red: '''
          document.getElementById('FF0000').click(); 
        ''',
  Colour.Yellow: '''
          document.getElementById('FFFF00').click(); 
        ''',
  Colour.Blue: '''
          document.getElementById('0000FF').click(); 
        ''',
  Colour.Green: '''
          document.getElementById('00FF00').click(); 
        ''',
  Colour.Brown: '''
          document.getElementById('A52A2A').click(); 
        ''',
  Colour.White: '''
          document.getElementById('FFFFFF').click(); 
        ''',
  Colour.Orange: '''
          document.getElementById('FFA500').click(); 
        ''',
  Colour.DarkBlue: '''
          document.getElementById('00008B').click(); 
        ''',
  Colour.LightBlue: '''
          document.getElementById('ADD8E6').click(); 
        ''',
  Colour.Pink: '''
          document.getElementById('FFC0CB').click(); 
        ''',
  Colour.Purple: '''
          document.getElementById('800080').click(); 
        ''',
  Colour.DarkGreen: '''
          document.getElementById('006400').click(); 
        ''',
};

const Map<Shape, int> shapePrices = {
  Shape.MiniStandard: 20,
  Shape.MiniHeart: 10,
  Shape.StandardCake: 30,
  Shape.HeartCake: 25,
  Shape.SheetCake: 5,
  Shape.SquareCake: 5
};
const Map<Flavor, int> flavorPrices = {
  Flavor.Vanilla: 2,
  Flavor.ChocoCrunch: 3,
  Flavor.RedVelvet: 4,
  Flavor.Nutella: 5,
  Flavor.Fruits: 5,
  Flavor.Cinnamon: 5,
  Flavor.Pistachio: 0,
};
const Map<Colour, int> colourPrices = {
  Colour.Red: 0,
  Colour.Yellow: 0,
  Colour.Blue: 0,
  Colour.Green: 0,
  Colour.Brown: 0,
  Colour.White: 0,
  Colour.Orange: 0,
  Colour.DarkBlue: 0,
  Colour.LightBlue: 0,
  Colour.Pink: 0,
  Colour.Purple: 0,
  Colour.DarkGreen: 0,
};
const Map<Topping, int> toppingPrices = {
  Topping.None: 0,
  Topping.Classic: 0,
  Topping.Christmas: 1,
  Topping.Snow: 0,
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