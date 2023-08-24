import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa el paquete intl

import '../widgets/drawer.dart';

class Inspeccion {
  final String placa;
  final String hora;
  final String tipo;
  final bool estado;

  Inspeccion({
    required this.placa,
    required this.hora,
    required this.tipo,
    required this.estado,
  });
}

class MyInspectionsPage extends StatelessWidget {

  final List<Inspeccion> inspecciones = [
    Inspeccion(placa: 'ABC123', hora: '10:00 AM', tipo: 'Auto', estado: true),
    Inspeccion(placa: 'XYZ789', hora: '02:30 PM', tipo: 'Camión', estado: false),
    Inspeccion(placa: 'MHY778', hora: '07:30 AM', tipo: 'Auto', estado: true),
    // Agrega más inspecciones aquí
  ];


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
        child: ListView.builder(
        itemCount: inspecciones.length,
        itemBuilder: (context, index) {
          return _buildInspeccionCard(inspecciones[index]);
        },
      ),
      ),
    );
  }

  Widget _buildInspeccionCard(Inspeccion inspeccion) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('${inspeccion.placa}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tipo: ${inspeccion.tipo}'),
            Text('${inspeccion.hora}'),
          ],
        ),
        trailing: CircleAvatar(
          backgroundColor: inspeccion.estado ? Colors.green : Colors.red,
          child: Icon(
            inspeccion.estado ? Icons.check : Icons.close,
            color: Colors.white,
          ),
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
