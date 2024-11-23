part of 'cake_customization_bloc.dart';

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

class ImagePicked extends CakeCustomizationEvent {
  final File imageFile;
  ImagePicked(this.imageFile);
}

class ImageRemoved extends CakeCustomizationEvent {}

