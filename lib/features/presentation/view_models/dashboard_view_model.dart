import 'package:flutter/foundation.dart';
import '../../domain/entities/device_health.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../data/repositories/dashboard_repository_impl.dart';

enum DashboardStatus { loading, loaded, error }

/// ViewModel du Dashboard.
///
/// Utilise `ChangeNotifier` (inclus dans Flutter, aucune dépendance pub
/// ajoutée) en attendant que l'équipe fixe la solution de gestion d'état
/// définitive pour tout le projet. Si l'équipe adopte Provider/Riverpod/
/// Bloc plus tard, seul ce fichier a besoin d'être adapté — les widgets de
/// `presentation/widgets/` n'en dépendent pas directement.
class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({DashboardRepository? repository})
      : _repository = repository ?? MockDashboardRepository() {
    _load();
  }

  final DashboardRepository _repository;

  DashboardStatus status = DashboardStatus.loading;
  DeviceHealth? data;
  String? errorMessage;

  Future<void> _load() async {
    status = DashboardStatus.loading;
    notifyListeners();
    try {
      data = await _repository.getDeviceHealth();
      status = DashboardStatus.loaded;
    } catch (e) {
      errorMessage = e.toString();
      status = DashboardStatus.error;
    }
    notifyListeners();
  }

  Future<void> refresh() => _load();

  /// TODO(equipe): brancher sur le vrai scan natif.
  void runQuickScan() {
    // Placeholder — à connecter au service natif de diagnostic.
  }

  /// TODO(equipe): brancher sur la vraie vérification des capteurs.
  void runSensorCheck() {
    // Placeholder — à connecter au service natif de capteurs.
  }
}
