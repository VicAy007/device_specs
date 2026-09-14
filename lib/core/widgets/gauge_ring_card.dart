import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// Carte générique avec jauge circulaire (anneau de progression).
///
/// Placé dans `core/widgets/` car réutilisable par n'importe quelle
/// feature (Dashboard aujourd'hui, potentiellement System Info demain),
/// au même titre que `AppButton` ou `AppCard`.
class GaugeRingCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String trailingText;
  final int percent;
  final Color ringColor;
  final String centerValueSuffix;
  final String centerCaption;
  final List<MapEntry<String, String>> footerRows;

  const GaugeRingCard({
    super.key,
    required this.icon,
    required this.label,
    required this.trailingText,
    required this.percent,
    required this.centerCaption,
    this.centerValueSuffix = '%',
    this.ringColor = AppColors.textPrimary,
    this.footerRows = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.uppercaseTiny,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  trailingText,
                  style: AppTypography.labelDataSm,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Center(
            child: SizedBox(
              width: 96,
              height: 96,
              child: CustomPaint(
                painter: _RingPainter(
                  percent: percent.clamp(0, 100) / 100,
                  ringColor: ringColor,
                  trackColor: AppColors.border,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: AppTypography.labelDataLg,
                          children: [
                            TextSpan(text: '$percent'),
                            TextSpan(
                              text: centerValueSuffix,
                              style:
                                  AppTypography.bodySm.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        centerCaption,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:
                            AppTypography.uppercaseTiny.copyWith(fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (footerRows.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 6),
            ...footerRows.map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        row.key,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTypography.bodySm.copyWith(fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        row.value,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AppTypography.labelDataSm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent; // 0..1
  final Color ringColor;
  final Color trackColor;

  _RingPainter({
    required this.percent,
    required this.ringColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - 6.5) / 2;
    const strokeWidth = 6.5;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * percent;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.ringColor != ringColor ||
        oldDelegate.trackColor != trackColor;
  }
}
