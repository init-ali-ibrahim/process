import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeHorizontalItemShimmer extends StatelessWidget {
  const HomeHorizontalItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Color baseShimmerColor = Colors.grey.shade300;
    Color highlightShimmerColor = Colors.grey.shade100;
    BorderRadiusGeometry borderRadius = BorderRadius.circular(10);

    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              width: 170,
              height: 155,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              width: 140,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
              ),
            ),
          ),
          const SizedBox(height: 4),
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
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              width: 60,
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
