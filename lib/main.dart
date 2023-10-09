import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'entities/user.dart';
import 'pages/home.dart';
import 'pages/find_plate.dart';
import 'pages/login.dart';
import 'pages/my_inspections.dart';
import 'widgets/app_theme.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => User(), // Crea una instancia de UserState
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/login', // Definimos la ruta inicial
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginPage());
            case '/home':
              return MaterialPageRoute(builder: (context) => const HomePage());
            case '/inspection':
              return MaterialPageRoute(
                  builder: (context) => const FindPlatePage());
            case '/my_inspections':
              return MaterialPageRoute(
                  builder: (context) => const MyInspectionsPage());
            default:
              return null;
          }
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
