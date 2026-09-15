/// Règles de validation pures — aucune dépendance à Flutter, donc
/// testables directement dans `test/core/validators_test.dart`.
///
/// Chaque fonction renvoie `null` si la valeur est valide, sinon le
/// message à afficher sous le champ.
abstract final class Validators {
  static final RegExp _emailPattern = RegExp(
    r"^[\w.!#$%&'*+/=?^`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$",
  );

  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Entre ton nom';
    if (v.length < 2) return 'Le nom doit contenir au moins 2 caractères';
    if (v.length > 50) return 'Le nom ne peut pas dépasser 50 caractères';
    return null;
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Entre ton adresse email';
    if (!_emailPattern.hasMatch(v)) return 'Format d\'adresse invalide';
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Choisis un mot de passe';
    if (v.length < 8) return 'Au moins 8 caractères';
    if (!v.contains(RegExp(r'[A-Za-z]'))) return 'Ajoute au moins une lettre';
    if (!v.contains(RegExp(r'[0-9]'))) return 'Ajoute au moins un chiffre';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    final v = value ?? '';
    if (v.isEmpty) return 'Confirme ton mot de passe';
    if (v != original) return 'Les deux mots de passe diffèrent';
    return null;
  }

  /// Score de robustesse de 0 à 4, utilisé par l'indicateur visuel.
  static int passwordScore(String value) {
    if (value.isEmpty) return 0;
    var score = 0;
    if (value.length >= 8) score++;
    if (value.length >= 12) score++;
    if (value.contains(RegExp(r'[A-Z]')) &&
        value.contains(RegExp(r'[a-z]'))) {
      score++;
    }
    if (value.contains(RegExp(r'[0-9]'))) score++;
    if (value.contains(RegExp(r'[^A-Za-z0-9]'))) score++;
    return score.clamp(0, 4);
  }
}