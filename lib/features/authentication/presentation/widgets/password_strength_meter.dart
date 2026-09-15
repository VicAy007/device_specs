import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

/// Indicateur de robustesse : quatre segments de 3px.
class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.score});

  /// De 0 (vide) à 4 (robuste).
  final int score;

  static const List<String> _labels = [
    '',
    'Faible',
    'Moyen',
    'Correct',
    'Robuste',
  ];

  @override
  Widget build(BuildContext context) {
    final s = score.clamp(0, 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 3,
                  decoration: BoxDecoration(
                    color: i < s ? AppColors.textPrimary : AppColors.border,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              if (i < 3) const SizedBox(width: AppSpacing.xs),
            ],
          ],
        ),
        if (s > 0) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            _labels[s],
            style: AppTypography.bodySm.copyWith(color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}