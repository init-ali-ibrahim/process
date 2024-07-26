import 'package:flutter/material.dart';
import 'package:process/color.dart';
import 'package:process/screens/cake_template.dart';
import 'package:process/screens/home/widgets/home_customize_widget.dart';
import 'package:process/screens/see_all_item/widgets/see_all_item_widget.dart';

class see_all_item extends StatefulWidget {
  const see_all_item({super.key});

  @override
  State<see_all_item> createState() => _see_all_itemState();
}

class _see_all_itemState extends State<see_all_item> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text('Fast delevery'),
          SizedBox(width: 10),
          Icon(
            Icons.connected_tv_sharp,
            color: colorDark,
          ),
        ]),
        // backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.92,
                ),
                children: [
                  CakeCard(
                    name: 'Cake Name',
                    img: 'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/cakes%2Fminiheart_redvelvet_red.png?alt=media',
                    type: 'vanil',
                    price: '20 BHD',
                    shape: Shape.MiniHeart,
                    flavor: Flavor.RedVelvet,
                    colour: Colour.Red,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class CakeCard extends StatelessWidget {
  CakeCard({super.key, required this.name, required this.price, required this.shape, required this.flavor, required this.colour, required this.img, required this.type});

  final String name;
  final String price;
  final String img;
  final String type;

  Shape shape;
  Flavor flavor;
  Colour colour;

  // CakeCard({
  //   required this.name,
  //   required this.flavor,
  //   required this.price,
  //   required this.shape,
  //   required this.flavor,
  //   required this.colour,
  // });

  @override
  Widget build(BuildContext  context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/cake_template',
            arguments: CakeTemplateArguments(
              shape: shape,
              colour: colour,
              flavor: flavor,
            ));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 0, top: 5),
        padding: const EdgeInsets.only(right: 10, left: 10, top: 4, bottom: 0),
        width: 160,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE7C9C9),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                    boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(1, 1), spreadRadius: 1, color: Color(0xFFE3E3E3))],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 20,
                  right: 20,
                  child: Image(image: NetworkImage(img)),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(0, 1), spreadRadius: 1, color: Color(0xFFE3E3E3))],
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(4), bottomLeft: Radius.circular(4))),
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    type,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorLight),
                      ),
                      Container(
                          decoration: const BoxDecoration(color: colorLight, borderRadius: BorderRadius.all(Radius.circular(4))),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class CakeTemplateArguments {
//   final Shape shape;
//   final Flavor flavor;
//   final Colour colour;
//
//   CakeTemplateArguments({
//     required this.shape,
//     required this.flavor,
//     required this.colour,
//   });
// }
