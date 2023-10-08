import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'entities/user.dart';
import 'pages/home.dart';
import 'pages/find_plate.dart';
import 'pages/login.dart';
import 'pages/myInspections.dart';
import 'widgets/appTheme.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
      create: (context) => User(),  // Crea una instancia de UserState
      child: MaterialApp( 
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
          default:
            return null;
        }
      },
      ),
    );
  }
}


