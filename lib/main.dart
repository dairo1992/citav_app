import 'package:flutter/material.dart';
import 'pages/help.dart';
import 'pages/home.dart';
import 'pages/inspection.dart';
import 'pages/login.dart';
import 'pages/myInspections.dart';
import 'pages/profile.dart';
import 'widgets/appTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: LoginPage(), // Inicia en la página de Login
      onGenerateRoute: (settings) {
        // Define el manejo de las rutas en el Drawer
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/inspection':
            return MaterialPageRoute(builder: (context) => InspectionPage());
          case '/my_inspections':
            return MaterialPageRoute(builder: (context) => MyInspectionsPage());
          case '/profile':
            return MaterialPageRoute(builder: (context) => ProfilePage());
          case '/help':
            return MaterialPageRoute(builder: (context) => HelpPage());
          default:
            return null;
        }
      },
    );
  }
}
