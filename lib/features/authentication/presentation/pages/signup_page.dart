import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/password_strength_meter.dart';

/// Écran de création de compte.
///
/// La page ne gère que l'état du **formulaire** (saisie, erreurs de
/// champ, visibilité). L'appel réseau et la session appartiennent à
/// `AuthViewModel` : voir le `TODO` dans [_submit], c'est le seul
/// endroit à modifier quand le ViewModel sera branché.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, this.onNavigateToLogin});

  /// Fourni par le routeur : `() => context.go(RouteNames.login)`.
  final VoidCallback? onNavigateToLogin;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  /// Erreur transverse renvoyée par le backend (email déjà pris, réseau…).
  String? _formError;

  int _passwordScore = 0;
  bool _submitted = false;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  /// Ne valide qu'après une première tentative d'envoi : afficher une
  /// erreur pendant que l'utilisateur tape encore son email est hostile.
  void _revalidate() {
    if (!_submitted) return;
    setState(() {
      _nameError = Validators.name(_name.text);
      _emailError = Validators.email(_email.text);
      _passwordError = Validators.password(_password.text);
      _confirmError =
          Validators.confirmPassword(_confirm.text, _password.text);
    });
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _submitted = true;
      _formError = null;
      _nameError = Validators.name(_name.text);
      _emailError = Validators.email(_email.text);
      _passwordError = Validators.password(_password.text);
      _confirmError =
          Validators.confirmPassword(_confirm.text, _password.text);
    });

    final isValid = _nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmError == null;
    if (!isValid) return;

    setState(() => _loading = true);

    // TODO (auth) remplacer par
    // await context.read<AuthViewModel>().signUp(
    //       name: _name.text.trim(),
    //       email: _email.text.trim(),
    //       password: _password.text,
    //     );
    // puis router vers le Dashboard en cas de succès, ou afficher
    // le message d'erreur du repository dans `_formError`.
    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {

    return AuthScaffold(
      title: 'Créer un compte',
      subtitle: 'Quelques secondes, et ton appareil se met à parler.',
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_formError != null) ...[
            _FormErrorBanner(message: _formError!),
            const SizedBox(height: AppSpacing.lg),
          ],
          AppTextField(
            controller: _name,
            label: 'Nom',
            hint: 'Estille',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            errorText: _nameError,
            autofillHints: const [AutofillHints.name],
            onChanged: (_) => _revalidate(),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _email,
            label: 'Email',
            hint: 'nom@exemple.com',
            prefixIcon: Icons.alternate_email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            errorText: _emailError,
            autofillHints: const [AutofillHints.email],
            onChanged: (_) => _revalidate(),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _password,
            label: 'Mot de passe',
            hint: '8 caractères minimum',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            textInputAction: TextInputAction.next,
            errorText: _passwordError,
            autofillHints: const [AutofillHints.newPassword],
            onChanged: (value) {
              setState(() => _passwordScore = Validators.passwordScore(value));
              _revalidate();
            },
          ),
          if (_password.text.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            PasswordStrengthMeter(score: _passwordScore),
          ],
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _confirm,
            label: 'Confirmation',
            hint: 'Retape le mot de passe',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            textInputAction: TextInputAction.done,
            errorText: _confirmError,
            onChanged: (_) => _revalidate(),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: 'Créer le compte',
            expand: true,
            isLoading: _loading,
            onPressed: _submit,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'En créant un compte, tu acceptes que DeviceSpecs lise les '
            'informations système de ton appareil.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySm.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tu as déjà un comte ?',
            style: AppTypography.bodyMd.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(width: AppSpacing.sm),
          _TextLink(
            label: 'Se connecter',
            onTap: widget.onNavigateToLogin ?? () {},
          ),
        ],
      ),
    );
  }
}

/// Bandeau d'erreur transverse : fond d'alerte, bordure 1px, pas d'icône
/// décorative — le message dit ce qui s'est passé et quoi faire.
class _FormErrorBanner extends StatelessWidget {
  const _FormErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.lossSurface,
        borderRadius: AppRadius.chip,
        border: Border.all(color: AppColors.loss, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, size: 14, color: AppColors.loss),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMd.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
 ? Colors.white : AppColors.loss,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Lien textuel avec soulignement au survol.
class _TextLink extends StatefulWidget {
  const _TextLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<_TextLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: AppTypography.bodyMd.copyWith(
            color: AppColors.gain,
            fontWeight: FontWeight.w500,
            decoration:
                _hovered ? TextDecoration.underline : TextDecoration.none,
            decorationColor: AppColors.gain,
          ),
        ),
      ),
    );
  }
}