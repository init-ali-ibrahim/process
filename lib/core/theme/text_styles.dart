import 'package:flutter/material.dart';
import 'package:process/core/constants/app_colors.dart';

class TextStyles {
  static const h1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w500,
  );
  static const letter50 = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryShade900,
  );

  static const letter30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryShade900,
  );
  static const letter20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryShade900,
  );
  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // static const appBarTitle = TextStyle(
  //   fontSize: 20,
  // );
  static const subtitles = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const regular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const greySubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.grey,
  );
  static const redDescription = TextStyle(
    fontSize: 13,
    color: AppColors.primaryShade300,
    fontWeight: FontWeight.w500,
  );
  static const greyDescription = TextStyle(
    fontSize: 13,
    color: AppColors.greyShade600,
    fontWeight: FontWeight.w500,
  );
  static const smallTips = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  );
  static const replayMessage =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const timeTips = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}
