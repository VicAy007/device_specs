import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/gauge_ring_card.dart';

/// Carte "RAM Load" du Dashboard.
class MemoryCard extends StatelessWidget {
  final int percent;
  final String ramType;
  final double freeGb;
  final double activeHeapGb;
  final double totalGb;
  final double zramSwapGb;

  const MemoryCard({
    super.key,
    required this.percent,
    required this.ramType,
    required this.freeGb,
    required this.activeHeapGb,
    required this.totalGb,
    required this.zramSwapGb,
  });

  /// Affiche 12 au lieu de 12.0, mais garde 8.1 tel quel.
  String _fmt(double value) =>
      value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return GaugeRingCard(
      icon: Icons.memory,
      label: 'RAM LOAD',
      trailingText: ramType,
      percent: percent,
      ringColor: AppColors.textSecondary,
      centerCaption: '${_fmt(freeGb)} GB Free',
      footerRows: [
        MapEntry('Active Heap', '${_fmt(activeHeapGb)} / ${_fmt(totalGb)} GB'),
        MapEntry('zRAM Swap', '${_fmt(zramSwapGb)} GB'),
      ],
    );
  }
}
