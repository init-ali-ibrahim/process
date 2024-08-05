// import 'package:flutter/material.dart';
//
// class cart_info_widget extends StatefulWidget {
//   const cart_info_widget(
//       {super.key,
//       required this.title,
//       required this.img,
//       required this.cash,});
//
//   final String title;
//   final String img;
//   final String cash;
//
//   @override
//   State<cart_info_widget> createState() => _cart_info_widgetState();
// }
//
// class _cart_info_widgetState extends State<cart_info_widget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//           border: Border.all(width: 1, color: Color(0xFFDADADA))
//         ),
//         margin: const EdgeInsets.only(left: 10),
//         width: 120,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image(
//                 image: AssetImage(widget.img),
//               ),
//             ),
//             Container(
//               width: 180,
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(8))),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.title,
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                   Text(
//                     widget.cash,
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF953282)),
//                   ),
//                   Container(
//                       decoration: BoxDecoration(
//                           // color: Color(0xFF953282),
//                           border: Border.all(
//                               width: 1, color: const Color(0xFF953282)),
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(4))),
//                       child: const Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.add,
//                             size: 20,
//                             color: Color(0xFF953282),
//                           ),
//                           Text('Add', style: TextStyle(color: Color(0xFF953282), fontWeight: FontWeight.bold),)
//                         ],
//                       )
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//   }
// }
