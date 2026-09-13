import '../../domain/entities/device_health.dart';
import '../../domain/repositories/dashboard_repository.dart';

/// Implémentation mock de [DashboardRepository], alignée sur la maquette
/// `dashboard_system_health_dark_minimal.html`.
///
/// TODO(equipe): remplacer par une implémentation qui interroge les
/// services natifs (Kotlin/Swift/etc. — voir `lib/services/native/` dans
/// l'architecture cible du README) une fois l'intégration native prête.
/// Le ViewModel n'a pas à changer : il ne dépend que de
/// [DashboardRepository].
class MockDashboardRepository implements DashboardRepository {
  @override
  Future<DeviceHealth> getDeviceHealth() async {
    // Simule une latence d'acquisition, comme un vrai appel natif.
    await Future.delayed(const Duration(milliseconds: 300));

    return const DeviceHealth(
      deviceId: 'G1AZG',
      deviceName: 'Pixel 8 Pro',
      osVersion: 'Android 14',
      chipset: 'Tensor G3',
      buildNumber: 'UQ1A.240205.004',
      healthPercent: 98,
      batteryPercent: 84,
      batteryTempCelsius: 34,
      chargeState: 'Fast Flow',
      cellHealth: 'Nominal',
      chargerLabel: 'USB-PD 27W',
      ramPercent: 68,
      ramUsedGb: 8.1,
      ramTotalGb: 12,
      ramFreeGb: 3.9,
      ramType: 'LPDDR5X',
      activeHeapGb: 8.1,
      zramSwapGb: 2.1,
      storagePercent: 50,
      storageUsedGb: 128,
      storageTotalGb: 256,
      storageFreeGb: 128,
      storageBus: 'UFS 4.0 Storage Bus',
      cpuName: 'Tensor G3 Frequency Map',
      cpuCoreLayout: '9 Cores (1x X3 • 4x A715 • 4x A510)',
      cpuLoadPercent: 24,
      cpuFreqPrimeGhz: 2.91,
      cpuFreqPerformanceGhz: 2.37,
      cpuFreqEfficiencyGhz: 1.70,
      cpuLoadHistory: [
        ChartPoint(0.00, 0.92),
        ChartPoint(0.08, 0.80),
        ChartPoint(0.17, 0.87),
        ChartPoint(0.25, 0.53),
        ChartPoint(0.33, 0.73),
        ChartPoint(0.42, 0.37),
        ChartPoint(0.50, 0.63),
        ChartPoint(0.58, 0.30),
        ChartPoint(0.67, 0.47),
        ChartPoint(0.75, 0.20),
        ChartPoint(0.83, 0.43),
        ChartPoint(0.92, 0.32),
        ChartPoint(1.00, 0.50),
      ],
      wifiStandard: 'Wi-Fi 7 (802.11be)',
      wifiConnected: true,
      wifiBand: 'Connected • 5 GHz Multi-Link',
      downlinkMbps: 348.5,
      linkPhyMbps: 1440,
      latencyMs: 14,
      jitterMs: 1,
      gatewayIp: '192.168.1.142',
    );
  }
}
