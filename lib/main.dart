import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/game/presentation/screens/start_screen.dart';
import 'package:eco_tycoon/core/services/logger_service.dart'; 

void main() {
  LoggerService.init();
  runApp(
    const ProviderScope(
      child: EcoTycoonApp(),
    ),
  );
}

class EcoTycoonApp extends ConsumerWidget {
  const EcoTycoonApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Eco Tycoon: Tiny Planet',
      themeMode: themeMode.when(
        data: (mode) => mode,
        loading: () => ThemeMode.system,
        error: (_, __) => ThemeMode.system,
      ),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const StartScreen(),
    );
  }
}
