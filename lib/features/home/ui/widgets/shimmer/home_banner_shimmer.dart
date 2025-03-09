import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeBannerShimmer extends StatelessWidget {
  const HomeBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 14),
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 10, width: 120, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 14, width: 160, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 30, width: 100, color: Colors.white),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}