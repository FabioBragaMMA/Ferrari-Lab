import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

// Notificador global para gerir o modo Dia/Noite em toda a app
final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier<bool>(true);

void main() {
  runApp(const FerrariLabApp());
}

class FerrariLabApp extends StatelessWidget {
  const FerrariLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'Ferrari Lab',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF0F0F0),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF1A0505),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
