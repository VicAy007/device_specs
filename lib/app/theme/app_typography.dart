import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Styles de texte partagés. Le mock utilise "Geist" pour le texte courant
/// et "JetBrains Mono" pour les valeurs chiffrées ("data").
///
/// Aucune dépendance pub n'est ajoutée ici : le texte courant garde la
/// police système (rendu proche de Geist) et les valeurs numériques
/// utilisent la police monospace système. Si l'équipe ajoute plus tard
/// `google_fonts` au pubspec.yaml commun, il suffira de remplacer
/// `fontFamily: 'monospace'` par `GoogleFonts.jetBrainsMono()` ici.
class AppTypography {
  AppTypography._();

  static const String _dataFontFamily = 'monospace';

  static const TextStyle headlineMd = TextStyle(
    fontSize: 16,
    height: 1.5,
    letterSpacing: -0.1,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineDevice = TextStyle(
    fontSize: 17,
    height: 1.3,
    letterSpacing: -0.1,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    height: 1.4,
    color: AppColors.textMuted,
  );

  static const TextStyle labelDataSm = TextStyle(
    fontFamily: _dataFontFamily,
    fontSize: 11,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelDataMd = TextStyle(
    fontFamily: _dataFontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelDataLg = TextStyle(
    fontFamily: _dataFontFamily,
    fontSize: 22,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle uppercaseTiny = TextStyle(
    fontFamily: _dataFontFamily,
    fontSize: 10,
    letterSpacing: 0.8,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  // --- Styles génériques (bouton, formulaire, en-têtes d'écran) ---------
  // Ajoutés pour couvrir core/widgets/ et les écrans d'authentification.
  // Même convention que le reste du fichier : couleur intégrée au style.

  static const TextStyle displayLg = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineLg = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMd = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLg = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMd = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Mappe l'échelle sur le TextTheme Material pour les widgets natifs.
  /// Les couleurs étant déjà fixées ci-dessus, aucun paramètre requis.
  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLg,
    headlineLarge: headlineLg,
    headlineMedium: headlineDevice,
    titleMedium: titleMd,
    bodyLarge: bodyLg,
    bodyMedium: bodyMd,
    bodySmall: bodySm,
    labelSmall: uppercaseTiny,
  );
}