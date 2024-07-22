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

enum Shape { MiniStandard, MiniHeart, StandardCake, HeartCake }
enum Flavor { Vanilla, ChocoCrunch, RedVelvet, Nutella }

class CakeCustomizationState extends Equatable {
  final Shape shape;
  final Flavor flavor;
  final String imagePath;
  // (Add color and toppings later)

  const CakeCustomizationState({
    required this.shape,
    required this.flavor,
    required this.imagePath,
    // ...
  });

  CakeCustomizationState copyWith({
    Shape? shape,
    Flavor? flavor,
    String? imagePath,
    // ...
  }) {
    return CakeCustomizationState(
      shape: shape ?? this.shape,
      flavor: flavor ?? this.flavor,
      imagePath: imagePath ?? this.imagePath,
      // ...
    );
  }

  @override
  List<Object> get props => [shape, flavor, imagePath]; // ...
}

class CakeCustomizationBloc extends Bloc<CakeCustomizationEvent, CakeCustomizationState> {
  CakeCustomizationBloc() : super(CakeCustomizationState(
    shape: Shape.MiniStandard,
    flavor: Flavor.Vanilla,
    imagePath: 'assets/cakes/mini_standard_vanilla.png', // Initial image
  )) {
    on<ShapeSelected>(_onShapeSelected);
    on<FlavorSelected>(_onFlavorSelected);
    // ... (Add onColorSelected later)
  }

  void _onShapeSelected(ShapeSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
      shape: event.shape,
      imagePath: _getImagePath(event.shape, state.flavor),
    ));
  }

  void _onFlavorSelected(FlavorSelected event, Emitter<CakeCustomizationState> emit) {
    emit(state.copyWith(
      flavor: event.flavor,
      imagePath: _getImagePath(state.shape, event.flavor),
    ));
  }

  // Helper function to get image path
  String _getImagePath(Shape shape, Flavor flavor) {
    String shapeString = shape.toString().split('.').last.toLowerCase();
    String flavorString = flavor.toString().split('.').last.toLowerCase();
    return 'assets/cakes/$shapeString\_$flavorString.png';
  }
}

class CakeCustomizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CakeCustomizationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Customize Your Cake'),
        ),
        body: BlocBuilder<CakeCustomizationBloc, CakeCustomizationState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(state.imagePath, height: 200),
                  SizedBox(height: 20),
                  Text('Choose a shape:', style: TextStyle(fontSize: 18)),
                  _buildShapeSelection(context),
                  SizedBox(height: 20),
                  Text('Choose a flavor:', style: TextStyle(fontSize: 18)),
                  _buildFlavorSelection(context),
                  // Add color selection section later
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShapeSelection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: Shape.values.map((shape) {
        return ElevatedButton(
          onPressed: () => context.read<CakeCustomizationBloc>().add(ShapeSelected(shape)),
          child: Text(shape.toString().split('.').last),
        );
      }).toList(),
    );
  }

  Widget _buildFlavorSelection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: Flavor.values.map((flavor) {
        return ElevatedButton(
          onPressed: () => context.read<CakeCustomizationBloc>().add(FlavorSelected(flavor)),
          child: Text(flavor.toString().split('.').last),
        );
      }).toList(),
    );
  }
}