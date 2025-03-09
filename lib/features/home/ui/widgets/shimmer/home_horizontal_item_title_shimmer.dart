import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeHorizontalItemTitleShimmer extends StatelessWidget {
  const HomeHorizontalItemTitleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Color baseShimmerColor = Colors.grey.shade300;
    Color highlightShimmerColor = Colors.grey.shade100;
    BorderRadiusGeometry borderRadius = BorderRadius.circular(10);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              width: 100,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              width: 40,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
