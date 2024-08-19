import 'package:flutter/material.dart';
import 'package:process/screens/color.dart';
import 'package:process/screens/cake_create/cake_create_screen.dart';

class SeeAllItemScreen extends StatefulWidget {
  const SeeAllItemScreen({super.key});

  @override
  State<SeeAllItemScreen> createState() => _SeeAllItemScreenState();
}

class _SeeAllItemScreenState extends State<SeeAllItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text('Cake'),
          SizedBox(width: 10),
          Icon(
            Icons.connected_tv_sharp,
            color: colorDark,
          ),
        ]),
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
                    name: 'Cake 1',
                    img: 'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/cakes%2Fminiheart_redvelvet_red.png?alt=media',
                    type: 'chokolite',
                    price: '100 ₸',
                    shape: Shape.MiniHeart,
                    flavor: Flavor.RedVelvet,
                    colour: Colour.Red,
                  ),
                  CakeCard(
                    name: 'Cake 2',
                    img: 'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/cakes%2Fminiheart_redvelvet_red.png?alt=media',
                    type: 'nutella',
                    price: '200 ₸',
                    shape: Shape.MiniHeart,
                    flavor: Flavor.RedVelvet,
                    colour: Colour.Red,
                  ),
                  CakeCard(
                    name: 'Cake 3',
                    img: 'https://firebasestorage.googleapis.com/v0/b/pushnotification-744c7.appspot.com/o/cakes%2Fminiheart_redvelvet_red.png?alt=media',
                    type: 'vanil',
                    price: '300 ₸',
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

class CakeTemplateArguments {
  final Shape shape;
  final Flavor flavor;
  final Colour colour;

  CakeTemplateArguments({
    required this.shape,
    required this.flavor,
    required this.colour,
  });
}
