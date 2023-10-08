import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class MyInspectionsPage extends StatefulWidget {
  @override
  _MyInspectionsPageState createState() => _MyInspectionsPageState();
}

class _MyInspectionsPageState extends State<MyInspectionsPage> {
  final List<DateTime> previousDates = [
    DateTime.now().subtract(Duration(days: 4)),
    DateTime.now().subtract(Duration(days: 3)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now(),
  ];

  List<Inspeccion> inspecciones = [];
  bool isLoading = false;
  String jsonResponse = "";
  String jsonRequest = ""; // Variable para almacenar el JSON de la solicitud
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Fecha seleccionada

  @override
  void initState() {
    super.initState();
    _fetchInspections();
  }

  Future<void> _fetchInspections() async {
    final apiUrl = 'https://ibingcode.com/public/listarInspecciones';
    final requestBody = jsonEncode({"fecha_inspeccion": selectedDate});

    try {
      setState(() {
        isLoading = true;
        jsonRequest = requestBody; // Guarda el JSON de la solicitud
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        final List<Inspeccion> fetchedInspections = responseData
            .map((inspeccionData) => Inspeccion(
                  placa: inspeccionData['placa'],
                  hora: inspeccionData['hora'],
                  tipo: inspeccionData['tipo_vehiculo'],
                  estado: inspeccionData['estado'] == 'Aprobada',
                ))
            .toList();

        setState(() {
          inspecciones = fetchedInspections;
          isLoading = false;
          jsonResponse = response.body; // Guarda el JSON de la respuesta
        });
      } else {
        print('Failed to fetch inspections: ${response.statusCode}');
        setState(() {
          isLoading = false;
          jsonResponse = response.body; // Guarda el JSON de la respuesta en caso de error
        });
      }
    } catch (error) {
      print('Error fetching inspections: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspecciones realizadas'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(64.0),
          child: MyTabBar(),
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : inspecciones.isEmpty
                ? Column(
                    children: [
                      Text('No hay inspecciones en esta fecha.'),
                      Text('JSON de la Solicitud:'),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(jsonRequest), // Muestra el JSON de la solicitud
                        ),
                      ),
                      Text('JSON de la Respuesta:'),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(jsonResponse), // Muestra el JSON de la respuesta
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: inspecciones.length,
                          itemBuilder: (context, index) {
                            return _buildInspeccionCard(inspecciones[index]);
                          },
                        ),
                      ),
                      Text('JSON de la Solicitud:'),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(jsonRequest), // Muestra el JSON de la solicitud
                        ),
                      ),
                      Text('JSON de la Respuesta:'),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(jsonResponse), // Muestra el JSON de la respuesta
                        ),
                      ),
                    ],
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
      length: 5,
      initialIndex: previousDates.length - 1,
      child: TabBar(
        isScrollable: true,
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
        ),
        tabs: [
          for (DateTime date in previousDates)
            Tab(
              text: _formatDate(date),
            ),
        ],
        labelStyle: TextStyle(fontSize: 30),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('d/MM/yy').format(date);
  }
}
