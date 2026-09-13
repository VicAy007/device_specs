import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Barre de navigation basse reproduisant le mock (Dashboard / Specs /
/// Profile).
///
/// ⚠️ IMPORTANT POUR L'ÉQUIPE : cette barre est partagée entre les 3 pages
/// (Dashboard, Specs, Profile — voir la section "Navigation" du README).
/// Elle est fournie ici comme référence visuelle fidèle au mock, mais son
/// intégration finale dans le routing global (`lib/app/router/`) doit être
/// décidée avec l'équipe pour éviter que plusieurs personnes créent
/// chacune leur propre bottom nav. Idéalement, un seul membre l'intègre
/// une fois dans le shell de navigation et tout le monde le réutilise.
class DashboardBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const DashboardBottomNav({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  static const _items = [
    _NavItemData(icon: Icons.monitor_heart_outlined, label: 'Dashboard'),
    _NavItemData(icon: Icons.memory, label: 'Specs'),
    _NavItemData(icon: Icons.tune, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.95),
            border: const Border(
              top: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final active = index == currentIndex;
              final color =
                  active ? AppColors.textPrimary : AppColors.textMuted;
              return InkWell(
                onTap: onTap == null ? null : () => onTap!(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.icon, size: 22, color: color),
                      const SizedBox(height: 2),
                      Text(
                        item.label.toUpperCase(),
                        style: AppTypography.uppercaseTiny.copyWith(
                          color: color,
                          fontWeight:
                              active ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  const _NavItemData({required this.icon, required this.label});
}
