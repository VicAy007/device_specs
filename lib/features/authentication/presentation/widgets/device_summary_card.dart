import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Carte "Device Summary" : identifiant de l'appareil, nom, build, et
/// pastille d'état de santé globale ("Healthy • 98%").
class DeviceSummaryCard extends StatelessWidget {
  final String deviceId;
  final String deviceName;
  final String osVersion;
  final String chipset;
  final String buildNumber;
  final int healthPercent;

  const DeviceSummaryCard({
    super.key,
    required this.deviceId,
    required this.deviceName,
    required this.osVersion,
    required this.chipset,
    required this.buildNumber,
    required this.healthPercent,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.smartphone,
                        size: 17, color: AppColors.textSecondary),
                    const SizedBox(width: 6),
                    Text(
                      'DEVICE ID #$deviceId',
                      style: AppTypography.uppercaseTiny,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$deviceName • $osVersion',
                  style: AppTypography.headlineDevice,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$chipset • Build $buildNumber',
                  style: AppTypography.bodySm.copyWith(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceChip,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'HEALTHY • $healthPercent%',
                  style: AppTypography.uppercaseTiny
                      .copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
