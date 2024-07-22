// import 'package:flutter/material.dart';
//
// var countCity = "";
//
// showAppbarCountry(BuildContext context) async {
//   final cityName = await showModalBottomSheet<int>(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         padding: const EdgeInsets.all(20),
//         height: 300,
//         width: MediaQuery
//             .of(context)
//             .size
//             .width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'Выберите город доставки',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context, 0);
//                   },
//                   child: Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: const BoxDecoration(
//                           color: Color(0xFFEED4E5),
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Container(
//                         width: 80,
//                         child: const Column(
//                           children: [
//                             Image(
//                               image: AssetImage('assets/almaty-logo.png'),
//                               width: 50,
//                             ),
//                             Text(
//                               'Алматы',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Color(0xFFA02F7F),
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                       )),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context, 1);
//                   },
//                   child: Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Container(
//                         width: 80,
//                         child: const Column(
//                           children: [
//                             Image(
//                                 image: AssetImage('assets/astana-logo.png'),
//                                 width: 50),
//                             Text(
//                               'Астана',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500),
//                             )
//                           ],
//                         ),
//                       )),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context, 2);
//                   },
//                   child: Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Container(
//                         width: 80,
//                         child: const Column(
//                           children: [
//                             Image(
//                                 image: AssetImage('assets/shymkent-logo.png'),
//                                 width: 50),
//                             Text(
//                               'Шымкент',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500),
//                             )
//                           ],
//                         ),
//                       )),
//                 )
//               ],
//             )
//           ],
//         ),
//       );
//     },
//   );
//
//   if (cityName != null) {
//     setState(() {
//       countCity = cityName as String;
//     });
//   }
// }