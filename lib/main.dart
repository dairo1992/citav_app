import 'package:flutter/material.dart';
import 'pages/help.dart';
import 'pages/home.dart';
import 'pages/findPlate.dart';
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
      initialRoute: '/login',  // Definimos la ruta inicial
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          case '/home':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/inspection':
            return MaterialPageRoute(builder: (context) => FindPlatePage());
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


