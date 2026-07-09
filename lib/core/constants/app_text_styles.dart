import 'package:flutter/material.dart';
import 'app_colors.dart';

/// All text styles come from here.
/// Never define a TextStyle inline in a widget.
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading1 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16, color: AppColors.textDark,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 13, color: AppColors.textLight,
  );
  static const TextStyle label = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark,
  );
}
