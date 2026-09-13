import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/gauge_ring_card.dart';

/// Carte "Battery" du Dashboard.
class BatteryCard extends StatelessWidget {
  final int percent;
  final int temperatureCelsius;
  final String chargerLabel;
  final String chargeState;
  final String cellHealth;

  const BatteryCard({
    super.key,
    required this.percent,
    required this.temperatureCelsius,
    required this.chargerLabel,
    required this.chargeState,
    required this.cellHealth,
  });

  @override
  Widget build(BuildContext context) {
    return GaugeRingCard(
      icon: Icons.bolt,
      label: 'BATTERY',
      trailingText: '$temperatureCelsius°C',
      percent: percent,
      ringColor: AppColors.textPrimary,
      centerCaption: chargerLabel,
      footerRows: [
        MapEntry('Charge State', chargeState),
        MapEntry('Cell Health', cellHealth),
      ],
    );
  }
}
