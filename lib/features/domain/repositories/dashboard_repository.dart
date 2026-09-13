import '../entities/device_health.dart';

/// Contrat (Domain) pour l'accès aux données de santé de l'appareil.
///
/// La Presentation (ViewModel) dépend de cette abstraction, jamais d'une
/// implémentation concrète — voir `data/repositories/
/// dashboard_repository_impl.dart` pour l'implémentation actuelle (mock),
/// destinée à être remplacée par une implémentation branchée sur les
/// platform channels natifs.
abstract class DashboardRepository {
  Future<DeviceHealth> getDeviceHealth();
}
