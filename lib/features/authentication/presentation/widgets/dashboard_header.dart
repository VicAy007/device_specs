import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// En-tête fixe de la page Dashboard : logo + titre à gauche, avatar de
/// profil à droite.
///
/// NOTE POUR L'ÉQUIPE : spécifique à l'onglet Dashboard (sous-titre
/// "Dashboard"). Si un header commun à tout l'app existe déjà, coordonnez-
/// vous avant d'en ajouter un second.
class DashboardHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const DashboardHeader({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.9),
            border: const Border(
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: Row(
            children: [
              _Logo(),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DeviceSpecs',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'DASHBOARD',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: AppColors.textMuted,
                      fontSize: 10,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.surfaceChip,
                    child: Icon(
                      Icons.person_outline,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder tant que l'asset logo officiel n'est pas versionné.
    // Remplacer par Image.asset('assets/images/logo.png') une fois
    // l'asset ajouté (voir assets/images/ dans l'architecture cible).
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.memory, size: 18, color: AppColors.background),
    );
  }
}
