import 'package:flutter/material.dart';

import 'app/theme/app_theme.dart';
import 'features/authentication/presentation/pages/signup_page.dart';

void main() => runApp(const DeviceSpecsApp());

/// Bascule de thème minimale, le temps que la gestion d'état définitive
/// soit choisie. Le `ProfileViewModel` prendra sa place.
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.dark);

class DeviceSpecsApp extends StatelessWidget {
  const DeviceSpecsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'DeviceSpecs',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          // TODO(router): remplacer par AppRouter une fois les routes
          // /signup, /login, /dashboard déclarées.
          home: SignUpPage(
            onNavigateToLogin: () {},
          ),
          
        );
      },
    );
  }
}