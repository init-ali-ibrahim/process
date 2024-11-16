import 'package:flutter/material.dart';

class HomeAppbarWidget extends StatelessWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      pinned: true,
      // snap: true,
      // floating: true,
      surfaceTintColor: Colors.transparent,
      // shadowColor: const Color(0xFFF5F5F5),
      title: SafeArea(
          child: Row(
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  // _launchUrl('https://samalcakes.kz/');
                },
                child: Image.asset('assets/image/logo.png', width: 90),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Доставка в',
                    style: TextStyle(fontSize: 14),
                  ),
                  InkWell(
                      onTap: () async {
                        // showAppbarCountry(context);
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 85,
                            child: Text(
                              'countCity',
                              style: const TextStyle(/*color: colorDark,*/ fontSize: 20),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            // color: colorDark,
                          ),
                        ],
                      )),
                ],
              ),
            ],
          )),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58.0),
          child: SafeArea(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F0F0),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Color(0xFF313131),
                    ),
                    onPressed: () {
                      // widget;
                    },
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        // _searchProducts(query, 'almaty');
                      },
                      decoration: const InputDecoration(
                        hintText: 'Поиск',
                        border: InputBorder.none,
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                        hintStyle: TextStyle(fontSize: 14, color: Color(0xFF313131), fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
