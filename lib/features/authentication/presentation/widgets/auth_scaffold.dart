import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/metric_chip.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_breakpoints.dart';

/// Coquille commune aux écrans Login et Sign Up.
///
/// - `< 1024px` : colonne unique.
/// - `>= 1024px` : deux volets, marque à gauche, formulaire encadré à droite.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.form,
    required this.footer,
  });

  final String title;
  final String subtitle;
  final Widget form;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= AppBreakpoints.desktop;

            final panel = _FormPanel(
              title: title,
              subtitle: subtitle,
              form: form,
              footer: footer,
              boxed: isWide,
            );

            if (!isWide) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.gutterMobile,
                  vertical: AppSpacing.xl,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AuthHeader(),
                        const SizedBox(height: AppSpacing.xxl),
                        panel,
                      ],
                    ),
                  ),
                ),
              );
            }

            return Row(
              children: [
                const Expanded(child: _BrandPane()),
                Container(width: 1, color: AppColors.border),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: panel,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FormPanel extends StatelessWidget {
  const _FormPanel({
    required this.title,
    required this.subtitle,
    required this.form,
    required this.footer,
    required this.boxed,
  });

  final String title;
  final String subtitle;
  final Widget form;
  final Widget footer;
  final bool boxed;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTypography.headlineLg.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          style: AppTypography.bodyMd.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: AppSpacing.xl),
        form,
        const SizedBox(height: AppSpacing.xl),
        Container(height: 1, color: AppColors.border),
        const SizedBox(height: AppSpacing.lg),
        footer,
      ],
    );

    if (!boxed) return content;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.module,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: content,
    );
  }
}

class _BrandPane extends StatelessWidget {
  const _BrandPane();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AuthHeader(),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Understand\nyour device.',
            style: AppTypography.displayLg.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.lg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Text(
              'Processeur, mémoire, stockage, batterie, capteurs : '
              'DeviceSpecs lit les APIs Android et iOS et te rend les '
              'chiffres bruts, sans arrondi ni valeur inventée.',
              style: AppTypography.bodyLg.copyWith(color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            children: [
              const StatusPip(),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Android  ·  iOS',
                style: AppTypography.uppercaseTiny
                    .copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Marque compacte : pastille + nom.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.surfaceChip,
            borderRadius: AppRadius.chip,
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: const Icon(
            Icons.hexagon_outlined,
            size: 15,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'DeviceSpecs',
          style: AppTypography.titleMd.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}