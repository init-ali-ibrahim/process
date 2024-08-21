import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:process/screens/cake_create/cake_create_screen.dart';

part 'cake_customization_event.dart';
part 'cake_customization_state.dart';

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