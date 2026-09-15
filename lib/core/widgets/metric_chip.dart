import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

/// Pastille d'état monochrome : cercle plein de 4 à 8px.
///
/// Le design étant strictement noir & blanc, il n'y a pas de variante
/// "gain/loss" colorée ici : `active` (blanc) vs `idle` (gris muet).
class StatusPip extends StatelessWidget {
  const StatusPip({super.key, this.active = true, this.size = 6});

  final bool active;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.success : AppColors.textMuted;

    return Container(
      width: size.clamp(4, 8),
      height: size.clamp(4, 8),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}