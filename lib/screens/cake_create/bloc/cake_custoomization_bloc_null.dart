// import 'dart:io';
//
// import 'package:bloc/bloc.dart' show Bloc, Emitter;
// import 'package:equatable/equatable.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:process/screens/cake_create/cake_create_screen.dart';
//
// part 'customization_event.dart';
// part 'customization_state.dart';
//
// class CakeCustomizationBloc extends Bloc<CakeCustomizationEvent, CakeCustomizationState> {
//   CakeCustomizationBloc()
//       : super(
//     CakeCustomizationState(
//       shape: Shape.MiniHeart,
//       flavor: Flavor.RedVelvet,
//       colour: Colour.White,
//       topping: Topping.None,
//       imagePath: '',
//       totalPrice: _calculateInitialTotalPrice(),
//       isLoadingImage: true,
//       shapeImagePath: '',
//       flavorImagePath: '',
//       colourImagePath: '',
//       toppingImagePath: '',
//       shapeName: '',
//       flavorName: '',
//       colourName: '',
//       toppingName: '',
//     ),
//   ) {
//     on<ShapeSelected>(_onShapeSelected);
//     on<FlavorSelected>(_onFlavorSelected);
//     on<ColourSelected>(_onColourSelected);
//     on<ToppingSelected>(_onToppingSelected);
//   }
//
//   static double _calculateInitialTotalPrice() {
//     return shapePrices[Shape.MiniStandard]! + flavorPrices[Flavor.Vanilla]! + colourPrices[Colour.Red]! + toppingPrices[Topping.Classic]!;
//   }
//
//   double _calculateTotalPrice(Shape shape, Flavor flavor, Colour colour, Topping topping) {
//     return shapePrices[shape]! + flavorPrices[flavor]! + colourPrices[colour]! + toppingPrices[topping]!;
//   }
//
//   void _onShapeSelected(ShapeSelected event, Emitter<CakeCustomizationState> emit) {
//     emit(state.copyWith(
//         shape: event.shape, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(event.shape, state.flavor, state.colour, state.topping)));
//     // _getImagePath(event.shape, state.flavor, state.colour, state.topping).then((imagePath) {
//     //   emit(state.copyWith(
//     //     imagePath: imagePath,
//     //     isLoadingImage: false,
//     //   ));
//     // }).catchError((error) {});
//   }
//
//   void _onFlavorSelected(FlavorSelected event, Emitter<CakeCustomizationState> emit) {
//     emit(state.copyWith(
//         flavor: event.flavor, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, event.flavor, state.colour, state.topping)));
//     // _getImagePath(state.shape, event.flavor, state.colour, state.topping).then((imagePath) {
//     //   emit(state.copyWith(
//     //     imagePath: imagePath,
//     //     isLoadingImage: false,
//     //   ));
//     // }).catchError((error) {});
//   }
//
//   void _onColourSelected(ColourSelected event, Emitter<CakeCustomizationState> emit) {
//     emit(state.copyWith(
//         colour: event.colour, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, state.flavor, event.colour, state.topping)));
//     // _getImagePath(state.shape, state.flavor, event.colour, state.topping).then((imagePath) {
//     //   emit(state.copyWith(
//     //     imagePath: imagePath,
//     //     isLoadingImage: false,
//     //   ));
//     // }).catchError((error) {});
//   }
//
//   void _onToppingSelected(ToppingSelected event, Emitter<CakeCustomizationState> emit) {
//     emit(state.copyWith(
//         topping: event.topping, imagePath: null, isLoadingImage: true, totalPrice: _calculateTotalPrice(state.shape, state.flavor, state.colour, event.topping)));
//     // _getImagePath(state.shape, state.flavor, state.colour, event.topping).then((imagePath) {
//     //   emit(state.copyWith(
//     //     imagePath: imagePath,
//     //     isLoadingImage: false,
//     //   ));
//     // }).catchError((error) {});
//   }
//
// // Future<String> _getImagePath(Shape shape, Flavor flavor, Colour colour, Topping topping) {
// //   String shapeString = shape.toString().split('.').last.toLowerCase();
// //   String flavorString = flavor.toString().split('.').last.toLowerCase();
// //   String colourString = colour.toString().split('.').last.toLowerCase();
// //   String toppingString = topping.toString().split('.').last.toLowerCase();
// //   Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('cakes/$shapeString\_$flavorString\_$colourString\_$toppingString.png');
// //   Future<String> downloadURL = ref.getDownloadURL();
// //   return downloadURL;
// // }
// }



// Widget _buildCustomSelection(BuildContext context) {
//   File? _imageFile;
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   void _removeImage() {
//     setState(() {
//       _imageFile = null;
//     });
//   }
//
//   return SingleChildScrollView(
//     child: BlocBuilder<CakeCustomizationBloc, CakeCustomizationState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Container(
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(8)),
//                     color: const Color(0xFFFFFFFF),
//                     border: Border.all(width: 1, color: const Color(0xFFDADADA))),
//                 child: InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: () {},
//                   child: Container(
//                     height: 50,
//                     padding: const EdgeInsets.only(bottom: 8, top: 8, left: 10, right: 10),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Дополнительно',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         Icon(Icons.add, color: Color(0xFF953282)),
//                       ],
//                     ),
//                   ),
//                 )),
//             Container(
//               margin: const EdgeInsets.all(10),
//               child: _imageFile == null
//                   ? GestureDetector(
//                       onTap: _pickImage,
//                       child: DottedBorder(
//                         color: Colors.grey,
//                         strokeWidth: 2,
//                         dashPattern: const [6, 6],
//                         borderType: BorderType.RRect,
//                         radius: const Radius.circular(12),
//                         child: Container(
//                           width: double.infinity,
//                           height: 180,
//                           child: const Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   'Нажмите, чтобы выбрать изображение',
//                                   style: TextStyle(color: Colors.grey, fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   : Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.file(
//                             _imageFile!,
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           right: 8,
//                           top: 8,
//                           child: GestureDetector(
//                             onTap: _removeImage,
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                 color: Colors.red,
//                                 shape: BoxShape.circle,
//                               ),
//                               padding: const EdgeInsets.all(8),
//                               child: const Icon(Icons.delete, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   var apiProduct = Product(
//                       '',
//                       state.totalPrice,
//                       state.flavor.toString(),
//                       state.colour.toString(),
//                       state.shape.toString(),
//                       'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2Fhand-drawn-birthday-icon-illustration_23-2151630913.jpg?alt=media&token=bfed0b0c-6337-4fd1-abe6-b0a7b9f70a48',
//                       99,
//                       'costume',
//                       'costume',
//                       _imageFile!);
//
//                   context.read<CartBloc>().add(AddProduct(apiProduct));
//
//                   Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(builder: (context) => Navbar(initialPageIndex: 1)),
//                     (Route<dynamic> route) => false,
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text('Добавить в корзину1'),
//               ),
//             )
//           ],
//         );
//       },
//     ),
//   );
// }



// Future<String> _getImagePath(Shape shape, Flavor flavor, Colour colour, Topping topping) async {
//   String shapeString = shape.toString().split('.').last.toLowerCase();
//   String flavorString = flavor.toString().split('.').last.toLowerCase();
//   String colorString = colour.toString().split('.').last.toLowerCase();
//   String toppingString = topping.toString().split('.').last.toLowerCase();
//   Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('cakes/$shapeString\_$flavorString\_$colorString\_$toppingString.png');
//   Future<String> downloadURL = ref.getDownloadURL();
//   return downloadURL;
// }




// ElevatedButton(
// onPressed: () async {
// var apiProduct = Product(
// state.shape.toString(),
// state.totalPrice,
// state.flavor.toString(),
// state.colour.toString(),
// state.shape.toString(),
// 'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/main_screen_item%2Fhand-drawn-birthday-icon-illustration_23-2151630913.jpg?alt=media&token=bfed0b0c-6337-4fd1-abe6-b0a7b9f70a48',
// 99,
// 'costume',
// '',
// state.selectedImage! ?? File(''));
//
// context.read<CartBloc>().add(AddProduct(apiProduct));
//
// Navigator.of(context).pushAndRemoveUntil(
// MaterialPageRoute(builder: (context) => Navbar(initialPageIndex: 1)),
// (Route<dynamic> route) => false,
// );
// },
// style: ElevatedButton.styleFrom(
// minimumSize: const Size(double.infinity, 50),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: const Text('Добавить в корзину'),
// ),
