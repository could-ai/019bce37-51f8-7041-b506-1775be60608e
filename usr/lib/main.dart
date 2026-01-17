import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GozzhupApp());
}

class GozzhupApp extends StatelessWidget {
  const GozzhupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOZZHUP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
