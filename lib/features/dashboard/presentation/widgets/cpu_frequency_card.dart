import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/device_health.dart';

/// Carte "Tensor G3 Frequency Map" : mini-graphique de charge CPU +
/// fréquences des 3 clusters de cœurs (Prime / Performance / Efficiency).
class CpuFrequencyCard extends StatelessWidget {
  final String title;
  final String coreLayout;
  final int loadPercent;
  final double primeGhz;
  final double performanceGhz;
  final double efficiencyGhz;
  final List<ChartPoint> history;

  const CpuFrequencyCard({
    super.key,
    required this.title,
    required this.coreLayout,
    required this.loadPercent,
    required this.primeGhz,
    required this.performanceGhz,
    required this.efficiencyGhz,
    required this.history,
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceChip,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.developer_board,
                    size: 18, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.headlineMd),
                    Text(coreLayout, style: AppTypography.uppercaseTiny),
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
                child:
                    Text('$loadPercent%', style: AppTypography.labelDataSm),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 80,
            padding: const EdgeInsets.fromLTRB(4, 6, 4, 2),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: CustomPaint(
              size: Size.infinite,
              painter: _CpuChartPainter(points: history),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _CoreStat(
                    label: 'PRIME',
                    value: '${primeGhz.toStringAsFixed(2)} GHz'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CoreStat(
                    label: 'PERFORMANCE',
                    value: '${performanceGhz.toStringAsFixed(2)} GHz'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CoreStat(
                  label: 'EFFICIENCY',
                  value: '${efficiencyGhz.toStringAsFixed(2)} GHz',
                  muted: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CoreStat extends StatelessWidget {
  final String label;
  final String value;
  final bool muted;

  const _CoreStat({
    required this.label,
    required this.value,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceChip.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(label, style: AppTypography.uppercaseTiny),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.labelDataSm.copyWith(
              fontWeight: FontWeight.w600,
              color: muted ? AppColors.textMuted : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Peintre du mini-graphique de charge CPU : grille pointillée, aire
/// dégradée sous la courbe, et ligne de tendance avec point final.
class _CpuChartPainter extends CustomPainter {
  final List<ChartPoint> points;

  _CpuChartPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final scaled = points
        .map((p) => Offset(p.x * size.width, p.y * size.height))
        .toList();

    _drawDashedLine(canvas, size, size.height * 0.25);
    _drawDashedLine(canvas, size, size.height * 0.60);

    final linePath = Path()..moveTo(scaled.first.dx, scaled.first.dy);
    for (final point in scaled.skip(1)) {
      linePath.lineTo(point.dx, point.dy);
    }

    final fillPath = Path.from(linePath)
      ..lineTo(scaled.last.dx, size.height)
      ..lineTo(scaled.first.dx, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.12),
          Colors.white.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.75
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);

    canvas.drawCircle(scaled.last, 2.5, Paint()..color = Colors.white);
  }

  void _drawDashedLine(Canvas canvas, Size size, double y) {
    final dashPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    const dashWidth = 3.0;
    const dashSpace = 3.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, y), Offset(startX + dashWidth, y), dashPaint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _CpuChartPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
