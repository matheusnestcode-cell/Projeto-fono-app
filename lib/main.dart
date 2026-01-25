import 'package:flutter/material.dart';
import 'package:protocolo_fono/screens/home_screen.dart';
import 'package:protocolo_fono/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protocolo Fonoaudiológico Digital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}