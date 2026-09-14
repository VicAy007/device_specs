/// Entité représentant l'état de santé de l'appareil, telle qu'affichée
/// sur le Dashboard.
///
/// Cette classe appartient à la couche Domain : elle ne dépend d'aucun
/// package Flutter ni d'aucune source de données concrète. La couche Data
/// (voir `data/repositories/dashboard_repository_impl.dart`) est
/// responsable de la construire, que ce soit à partir de données mockées
/// ou, plus tard, des platform channels natifs (Kotlin / Swift / etc.).
class DeviceHealth {
  final String deviceId;
  final String deviceName;
  final String osVersion;
  final String chipset;
  final String buildNumber;
  final int healthPercent;

  final int batteryPercent;
  final int batteryTempCelsius;
  final String chargeState;
  final String cellHealth;
  final String chargerLabel;

  final int ramPercent;
  final double ramUsedGb;
  final double ramTotalGb;
  final double ramFreeGb;
  final String ramType;
  final double activeHeapGb;
  final double zramSwapGb;

  final int storagePercent;
  final int storageUsedGb;
  final int storageTotalGb;
  final int storageFreeGb;
  final String storageBus;

  final String cpuName;
  final String cpuCoreLayout;
  final int cpuLoadPercent;
  final double cpuFreqPrimeGhz;
  final double cpuFreqPerformanceGhz;
  final double cpuFreqEfficiencyGhz;

  /// Points normalisés (x: 0..1, y: 0..1, 0 = haut du graphique) utilisés
  /// pour tracer la courbe de charge CPU, dans l'ordre chronologique.
  final List<ChartPoint> cpuLoadHistory;

  final String wifiStandard;
  final bool wifiConnected;
  final String wifiBand;
  final double downlinkMbps;
  final double linkPhyMbps;
  final int latencyMs;
  final int jitterMs;
  final String gatewayIp;

  const DeviceHealth({
    required this.deviceId,
    required this.deviceName,
    required this.osVersion,
    required this.chipset,
    required this.buildNumber,
    required this.healthPercent,
    required this.batteryPercent,
    required this.batteryTempCelsius,
    required this.chargeState,
    required this.cellHealth,
    required this.chargerLabel,
    required this.ramPercent,
    required this.ramUsedGb,
    required this.ramTotalGb,
    required this.ramFreeGb,
    required this.ramType,
    required this.activeHeapGb,
    required this.zramSwapGb,
    required this.storagePercent,
    required this.storageUsedGb,
    required this.storageTotalGb,
    required this.storageFreeGb,
    required this.storageBus,
    required this.cpuName,
    required this.cpuCoreLayout,
    required this.cpuLoadPercent,
    required this.cpuFreqPrimeGhz,
    required this.cpuFreqPerformanceGhz,
    required this.cpuFreqEfficiencyGhz,
    required this.cpuLoadHistory,
    required this.wifiStandard,
    required this.wifiConnected,
    required this.wifiBand,
    required this.downlinkMbps,
    required this.linkPhyMbps,
    required this.latencyMs,
    required this.jitterMs,
    required this.gatewayIp,
  });
}

/// Petit point (x, y) normalisé entre 0 et 1, sans dépendance sur
/// dart:ui.Offset pour garder l'entité indépendante du rendu (règle
/// Domain = pas de dépendance Flutter/UI).
class ChartPoint {
  final double x;
  final double y;
  const ChartPoint(this.x, this.y);
}
