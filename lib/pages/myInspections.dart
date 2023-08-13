import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa el paquete intl

import '../widgets/drawer.dart';

class MyInspectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspecciones realizadas'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(64.0), // Ajusta la altura del AppBar
          child: MyTabBar(),
        ),
      ),
      drawer: DrawerPage(),
      body: Center(
        child: Text(
          '¡Hola desde la página mis inspecciones!',
          style: TextStyle(fontSize: 24), // Aumenta el tamaño de la fuente
        ),
      ),
    );
  }
}

class MyTabBar extends StatelessWidget {
  final List<DateTime> previousDates = [
    DateTime.now().subtract(Duration(days: 4)),
    DateTime.now().subtract(Duration(days: 3)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Número de pestañas
      initialIndex: previousDates.length - 1,
      child: TabBar(
        isScrollable: true, // Permite que las pestañas se desplacen horizontalmente
         indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Personaliza la forma del indicador
            side: BorderSide(
              color: Colors.green, // Cambia el color del último tab
              width: 2.0,
            ),
          ),
         ),
        tabs: [
          for (DateTime date in previousDates)
            Tab(
              text: _formatDate(date),
              // Ajusta el tamaño de las pestañas
              // Puedes ajustar el estilo según tus preferencias
              // labelStyle: TextStyle(fontSize: 18),
            ),
        ],
        labelStyle: TextStyle(fontSize: 30), // Ajusta el tamaño de las pestañas
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Utiliza el paquete intl para formatear la fecha en el formato deseado
    return DateFormat('d/MM/yy').format(date);
  }
}
