import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/perfil_screen.dart';
import 'theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
>>>>>>> 27342701e4b4c2d0a6ddaa8da386484f7fef3865

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Nota: Firebase.initializeApp() requer configuração prévia do google-services.json/GoogleService-Info.plist
  // try { await Firebase.initializeApp(); } catch (e) { print('Firebase error: $e'); }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protocolo Fonoaudiológico Digital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/perfil': (context) => const PerfilScreen(),
      },
    );
  }
}