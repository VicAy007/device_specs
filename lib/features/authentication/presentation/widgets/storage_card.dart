import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Carte "Internal Storage" : barre de progression linéaire + détails.
class StorageCard extends StatelessWidget {
  final String busLabel;
  final int percent;
  final int usedGb;
  final int totalGb;
  final int freeGb;

  const StorageCard({
    super.key,
    required this.busLabel,
    required this.percent,
    required this.usedGb,
    required this.totalGb,
    required this.freeGb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceChip,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.storage,
                    size: 18, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Internal Storage',
                        style: AppTypography.headlineMd),
                    Text(busLabel, style: AppTypography.uppercaseTiny),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$percent%', style: AppTypography.labelDataMd),
                  const Text('ALLOCATED', style: AppTypography.uppercaseTiny),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: percent.clamp(0, 100) / 100,
              minHeight: 6,
              backgroundColor: AppColors.border,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$usedGb GB Used of $totalGb GB',
                  style: AppTypography.bodySm.copyWith(fontSize: 11)),
              Text('$freeGb GB Free',
                  style: AppTypography.labelDataSm
                      .copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
