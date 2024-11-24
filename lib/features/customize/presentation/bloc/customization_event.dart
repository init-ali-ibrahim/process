part of 'customization_bloc.dart';

abstract class CustomizationEvent extends Equatable {
  const CustomizationEvent();

  @override
  List<Object> get props => [];
}

class ShapeSelected extends CustomizationEvent {
  final Shape shape;

  const ShapeSelected(this.shape);

  @override
  List<Object> get props => [shape];
}

class FlavorSelected extends CustomizationEvent {
  final Flavor flavor;

  const FlavorSelected(this.flavor);

  @override
  List<Object> get props => [flavor];
}

class ColourSelected extends CustomizationEvent {
  final Colour colour;

  const ColourSelected(this.colour);

  @override
  List<Object> get props => [colour];
}

class ToppingSelected extends CustomizationEvent {
  final Topping topping;

  const ToppingSelected(this.topping);

  @override
  List<Object> get props => [topping];
}

class ImagePicked extends CustomizationEvent {
  final File imageFile;
  ImagePicked(this.imageFile);
}

class ImageRemoved extends CustomizationEvent {}

