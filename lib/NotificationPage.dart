// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   void initState() {
//     super.initState();
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(message.notification!.title!),
//             content: Text(message.notification!.body!),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     });
//
//     _firebaseMessaging.requestPermission();
//     _firebaseMessaging.getToken().then((String? token) {
//       assert(token != null);
//       print("Firebase Messaging Token: $token");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FCM Example'),
//       ),
//       body: Center(
//         child: Text('Listening for notifications...'),
//       ),
//     );
//   }
//
// }

// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedValue = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Modal Bottom Sheet Example')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Selected Value: $_selectedValue'),
//
//
//             ElevatedButton(
//               onPressed: () async {
//
//                 final result = await showModalBottomSheet<int>(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return _BottomSheetContent();
//                   },
//                 );
//
//                 if (result != null) {
//                   setState(() {
//                     _selectedValue = result;
//                   });
//                 }
//               },
//               child: Text('Show Bottom Sheet'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _BottomSheetContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: Column(
//         children: [
//           ListTile(
//             title: Text('Value 1'),
//             onTap: () => Navigator.pop(context, 1),
//           ),
//           ListTile(
//             title: Text('Value 2'),
//             onTap: () => Navigator.pop(context, 2),
//           ),
//           ListTile(
//             title: Text('Value 3'),
//             onTap: () => Navigator.pop(context, 3),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

// State
enum Shape { MiniStandard, MiniHeart, StandardCake, HeartCake }

enum Flavor { Vanilla, ChocoCrunch, RedVelvet, Nutella }

enum Colour { Red, Blue, Yellow, Green }

class CakeCustomizationState extends Equatable {
  final Shape shape;
  final Flavor flavor;
  final Colour colour;
  final String imagePath;

  final double totalPrice;

  const CakeCustomizationState({
    required this.shape,
    required this.flavor,
    required this.colour,
    required this.imagePath,
    required this.totalPrice,
  });

  CakeCustomizationState copyWith({
    Shape? shape,
    Flavor? flavor,
    Colour? colour,
    String? imagePath,
    double? totalPrice,
  }) {
    return CakeCustomizationState(
      shape: shape ?? this.shape,
      flavor: flavor ?? this.flavor,
      colour: colour ?? this.colour,
      imagePath: imagePath ?? this.imagePath,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object> get props => [shape, flavor, colour, imagePath, totalPrice];
}

// Bloc
class CakeCustomizationBloc extends Bloc<CakeCustomizationEvent, CakeCustomizationState> {
  CakeCustomizationBloc()
      : super(CakeCustomizationState(
          shape: Shape.MiniStandard,
          flavor: Flavor.Vanilla,
          colour: Colour.Red,
          imagePath: 'assets/cakes/ministandard_vanilla.png',
          totalPrice: 0
        )) {
    on<ShapeSelected>(_onShapeSelected);
    on<FlavorSelected>(_onFlavorSelected);
    on<ColourSelected>(_onColourSelected);
  }

  double _calculateTotalPrice(Shape shape, Flavor flavor, Colour colour) {
    return shapePrices[shape]! + flavorPrices[flavor]! + colourPrices[colour]!;
  }

  void _onShapeSelected(ShapeSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
      shape: event.shape,
      imagePath: _getImagePath(event.shape, state.flavor, state.colour),
      totalPrice: _calculateTotalPrice(event.shape, state.flavor, state.colour)
    ));
  }

  void _onFlavorSelected(FlavorSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
      flavor: event.flavor,
      imagePath: _getImagePath(state.shape, event.flavor, state.colour),
      totalPrice: _calculateTotalPrice(state.shape, event.flavor, state.colour)
    ));
  }

  void _onColourSelected(ColourSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
      colour: event.colour,
      imagePath: _getImagePath(state.shape, state.flavor, event.colour),
      totalPrice: _calculateTotalPrice(state.shape, state.flavor, event.colour)
    ));
  }

  String _getImagePath(Shape shape, Flavor flavor, Colour colour) {
    String shapeString = shape.toString().split('.').last.toLowerCase();
    String flavorString = flavor.toString().split('.').last.toLowerCase();
    String colourString = colour.toString().split('.').last.toLowerCase();
    return 'assets/cakes/$shapeString\_$flavorString\_$colourString.png';
  }
}

// Total Price
const Map<Shape, double> shapePrices = {
  Shape.MiniStandard: 20.0,
  Shape.MiniHeart: 10.0,
  Shape.StandardCake: 30.0,
  Shape.HeartCake: 25.0,
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

// UI
class CakeCustomizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CakeCustomizationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cake'),
          actions: [Text('data'), SizedBox(width: 20)],
        ),
        body: BlocBuilder<CakeCustomizationBloc, CakeCustomizationState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(state.imagePath, height: 200, width: MediaQuery.of(context).size.width,),

                  SizedBox(height: 20),
                  Text('shape:', style: TextStyle(fontSize: 18)),
                  _buildShapeSelection(context),

                  SizedBox(height: 20),
                  Text('flavor:', style: TextStyle(fontSize: 18)),
                  _buildFlavorSelection(context),

                  SizedBox(height: 20),
                  Text('flavor:', style: TextStyle(fontSize: 18)),
                  _buildColourSelection(context),

                  SizedBox(height: 20),
                  Text('${state.imagePath}'),
                  Text(
                    'Total Price: \$${state.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // Add color selection section later
                ],
              ),
            );
          },
        ),
      ),
    );
  }

    // Widget _buildShapeSelection(BuildContext context) {
    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: Shape.values.map((shape) {
    //       return ElevatedButton(
    //         onPressed: () => context.read<CakeCustomizationBloc>().add(ShapeSelected(shape)),
    //         child: Text(shape.toString().split('.').last),
    //       );
    //     }).toList(),
    //   );
    // }

  Widget _buildShapeSelection(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Shape.values.length,
        itemBuilder: (context, index) {
          final shape = Shape.values[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            // child: ElevatedButton(
            //   onPressed: () => context.read<CakeCustomizationBloc>().add(ShapeSelected(shape)),
            //   child: Text(shape.toString().split('.').last),
            // ),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CakeCustomizationBloc>().add(ShapeSelected(shape)),
                  child: Text(shape.toString().split('.').last),
                ),
                Text('\$${shapePrices[shape]!.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFlavorSelection(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Flavor.values.length,
        itemBuilder: (context, index) {
          final flavor = Flavor.values[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column( // Wrap ElevatedButton in a Column
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CakeCustomizationBloc>().add(FlavorSelected(flavor)),
                  child: Text(flavor.toString().split('.').last),
                ),
                Text('\$${flavorPrices[flavor]!.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildColourSelection(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Colour.values.length,
        itemBuilder: (context, index) {
          final colour = Colour.values[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column( // Wrap ElevatedButton in a Column
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CakeCustomizationBloc>().add(ColourSelected(colour)),
                  child: Text(colour.toString().split('.').last),
                ),
                Text('\$${colourPrices[colour]!.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
