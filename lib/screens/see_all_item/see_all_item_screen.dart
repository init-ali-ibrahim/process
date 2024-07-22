import 'package:flutter/material.dart';
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
        title:
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text('Fast delevery'),
          SizedBox(width: 10),
          Icon(
            Icons.connected_tv_sharp,
            color: Color(0xFF953282),
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
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.92,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CakeCard(
                    name: 'Cake Name',
                    flavor: 'Vanilla',
                    price: '20 BHD',
                  );
                },
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class CakeCard extends StatelessWidget {
  final String name;
  final String flavor;
  final String price;

  CakeCard({
    required this.name,
    required this.flavor,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/cake_create');
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 0, top: 5),
        padding: const EdgeInsets.only(right: 10, left: 10, top: 4, bottom: 0),
        // decoration: BoxDecoration(
        //     border: Border.all(width: 2.0, color: Colors.green),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.red,
        //           offset: Offset(1, 1),
        //           spreadRadius: 1,
        //           blurRadius: 1)
        //     ]
        // ),
        width: 160,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD0BFE8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 8,
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                          color: Color(0xFFE3E3E3))
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  left: 20,
                  right: 20,
                  child: Image(image: AssetImage('assets/ww.png')),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 1),
                        spreadRadius: 1,
                        color: Color(0xFFE3E3E3))
                  ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4))),
              padding: const EdgeInsets.only(
                  right: 10, top: 10, left: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'widget.title',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'vanilla',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '20 ₸',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF953282)),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFF953282),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
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
