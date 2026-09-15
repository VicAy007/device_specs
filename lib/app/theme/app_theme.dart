import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: AppColors.background,
    dividerColor: AppColors.border,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      primary: AppColors.textPrimary,
      onPrimary: AppColors.background,
      error: AppColors.error,
      outline: AppColors.border,
    ),
    textTheme: AppTypography.textTheme,
    splashFactory: NoSplash.splashFactory,
    highlightColor: const Color(0x00000000),
    visualDensity: VisualDensity.compact,
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: AppColors.background,
    dividerColor: AppColors.border,
    colorScheme: const ColorScheme.light(
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      primary: AppColors.textPrimary,
      onPrimary: AppColors.background,
      error: AppColors.error,
      outline: AppColors.border,
    ),
    textTheme: AppTypography.textTheme,
    splashFactory: NoSplash.splashFactory,
    highlightColor: const Color(0x00000000),
    visualDensity: VisualDensity.compact,
  );
}

