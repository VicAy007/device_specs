import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Carte "Quick Actions" du Dashboard (voir la structure du README :
/// Device Summary / Battery / Memory / Storage / CPU / Quick Actions).
/// Le mock l'appelle "Diagnostic Control" à l'écran — on garde ce libellé
/// visible tel quel, seul le nom de fichier suit la convention du projet.
///
/// Les callbacks sont optionnels : le membre qui implémente le scan natif
/// (platform channel) peut les brancher sans modifier ce fichier UI.
class QuickActionsCard extends StatelessWidget {
  final VoidCallback? onQuickScan;
  final VoidCallback? onSensorCheck;
  final String pollingLabel;

  const QuickActionsCard({
    super.key,
    this.onQuickScan,
    this.onSensorCheck,
    this.pollingLabel = 'POLLING LIVE (1s)',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('DIAGNOSTIC CONTROL',
                style: AppTypography.uppercaseTiny),
            Text(pollingLabel, style: AppTypography.uppercaseTiny),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: 'Quick Scan',
                icon: Icons.radar,
                filled: true,
                onPressed: onQuickScan,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionButton(
                label: 'Sensor Check',
                icon: Icons.sensors,
                filled: false,
                onPressed: onSensorCheck,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = filled ? AppColors.textPrimary : AppColors.surface;
    final foregroundColor =
        filled ? AppColors.background : AppColors.textPrimary;

    return SizedBox(
      height: 44,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: filled ? null : Border.all(color: AppColors.border),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: foregroundColor),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: AppTypography.headlineMd.copyWith(
                    fontSize: 14,
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
