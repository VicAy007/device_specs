import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import '../../app/theme/app_radius.dart';

enum AppButtonVariant { primary, secondary, destructive }

enum AppButtonSize { small, medium }

/// Bouton du design system "Dark Minimal".
///
/// Hauteur 36px (32px en `small`), rayon 4px, aucune ombre : l'état est
/// signalé par le fond et la bordure uniquement.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final style = _resolve(widget.variant);
    final height = widget.size == AppButtonSize.small ? 32.0 : 36.0;

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(style.foreground),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: 14, color: style.foreground),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          widget.label,
          style: AppTypography.bodyMd.copyWith(
            fontWeight: FontWeight.w500,
            color: style.foreground,
          ),
        ),
      ],
    );

    return Opacity(
      opacity: _enabled ? 1 : 0.38,
      child: MouseRegion(
        cursor:
            _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: _enabled ? widget.onPressed : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            height: height,
            width: widget.expand ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  _hovered && _enabled ? style.hoverBackground : style.background,
              borderRadius: AppRadius.chip,
              border: Border.all(
                color: _hovered && _enabled ? style.hoverBorder : style.border,
                width: 1,
              ),
            ),
            child: content,
          ),
        ),
      ),
    );
  }

  _ButtonStyle _resolve(AppButtonVariant variant) {
    switch (variant) {
      case AppButtonVariant.primary:
        return const _ButtonStyle(
          background: AppColors.textPrimary,
          hoverBackground: Color(0xFFE0E0E0),
          border: AppColors.textPrimary,
          hoverBorder: AppColors.textPrimary,
          foreground: AppColors.background,
        );
      case AppButtonVariant.secondary:
        return const _ButtonStyle(
          background: AppColors.surface,
          hoverBackground: AppColors.surfaceContainerHigh,
          border: AppColors.border,
          hoverBorder: AppColors.outline,
          foreground: AppColors.textPrimary,
        );
      case AppButtonVariant.destructive:
        return const _ButtonStyle(
          background: AppColors.surface,
          hoverBackground: AppColors.surfaceContainerHigh,
          border: AppColors.error,
          hoverBorder: AppColors.error,
          foreground: AppColors.error,
        );
    }
  }
}

class _ButtonStyle {
  const _ButtonStyle({
    required this.background,
    required this.hoverBackground,
    required this.border,
    required this.hoverBorder,
    required this.foreground,
  });

  final Color background;
  final Color hoverBackground;
  final Color border;
  final Color hoverBorder;
  final Color foreground;
}