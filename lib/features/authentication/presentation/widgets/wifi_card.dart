import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Carte "Wi-Fi 7" : statut de connexion + débit descendant + latence.
class WifiCard extends StatelessWidget {
  final String standard;
  final bool connected;
  final String bandLabel;
  final double downlinkMbps;
  final double linkPhyMbps;
  final int latencyMs;
  final int jitterMs;
  final String gatewayIp;

  const WifiCard({
    super.key,
    required this.standard,
    required this.connected,
    required this.bandLabel,
    required this.downlinkMbps,
    required this.linkPhyMbps,
    required this.latencyMs,
    required this.jitterMs,
    required this.gatewayIp,
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
                child: const Icon(Icons.wifi,
                    size: 18, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(standard,
                              style: AppTypography.headlineMd,
                              overflow: TextOverflow.ellipsis),
                        ),
                        if (connected) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.textPrimary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(bandLabel, style: AppTypography.uppercaseTiny),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceChip,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Text('ACTIVE LINK',
                    style: AppTypography.uppercaseTiny),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _WifiMetricBox(
                  label: 'DOWNLINK RATE',
                  value: downlinkMbps.toStringAsFixed(1),
                  unit: 'Mbps',
                  caption: 'Link PHY: ${linkPhyMbps.toStringAsFixed(0)} Mbps',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WifiMetricBox(
                  label: 'LATENCY & GATEWAY',
                  value: '$latencyMs',
                  unit: 'ms (Jitter ${jitterMs}ms)',
                  caption: gatewayIp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WifiMetricBox extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String caption;

  const _WifiMetricBox({
    required this.label,
    required this.value,
    required this.unit,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceChip.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.uppercaseTiny),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: AppTypography.labelDataMd
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              children: [
                TextSpan(text: value),
                TextSpan(
                  text: ' $unit',
                  style: AppTypography.bodySm.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            caption,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodySm.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
