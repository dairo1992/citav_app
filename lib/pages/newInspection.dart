import 'package:citav_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../entities/user.dart';

class NewInspection extends StatefulWidget {
  final String plateValue;
  final String modelo;
  final String numero_chasis;
  final String numero_motor;
  final String marca;
  final String tipo_servicio;
  final String tipo_vehiculo;
  final String organismo_transito;
  final String id_propietario;
  final String nombre_propietario;

  NewInspection({
    required this.plateValue,
    required this.modelo,
    required this.numero_chasis,
    required this.numero_motor,
    required this.marca,
    required this.tipo_servicio,
    required this.tipo_vehiculo,
    required this.organismo_transito,
    required this.id_propietario,
    required this.nombre_propietario,
  });

  @override
  _NewInspectionState createState() => _NewInspectionState();
}

class _NewInspectionState extends State<NewInspection> {
  Location location = Location();
  double? latitude;
  double? longitude;
  DateTime? selectedDate; // Variable para almacenar la fecha seleccionada
  String fechaIngreso = ""; // Variable para mostrar la fecha en el cuadro de diálogo

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locationData = await location.getLocation();
    if (mounted) {
      setState(() {
        latitude = _locationData.latitude;
        longitude = _locationData.longitude;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String firstPart = widget.plateValue.substring(0, 3);
    String secondPart = widget.plateValue.substring(3, 6);
     final user = Provider.of<User>(context);

    TextStyle textStyle = TextStyle(fontSize: 25.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Inspection', style: textStyle),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Imagen de la placa y texto
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/placa.png',
                        width: 350,
                        height: 200,
                      ),
                      Positioned(
                        left: 25,
                        child: Container(
                          width: 150,
                          child: Text(
                            firstPart,
                            style: TextStyle(
                              fontSize: 68,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        child: Container(
                          width: 150,
                          child: Text(
                            secondPart,
                            style: TextStyle(
                              fontSize: 68,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Contenedor para datos fijos
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _buildDataRow('Tipo de servicio', widget.tipo_servicio),
                        _buildDataRow('Marca', widget.marca),
                        _buildDataRow('Modelo', widget.modelo),
                        _buildDataRow('Número de Chasis', widget.numero_chasis),
                        _buildDataRow('Número de Motor', widget.numero_motor),
                        _buildDataRow('Tipo de Vehículo', widget.tipo_vehiculo),
                        _buildDataRow('Organismo de Tránsito', widget.organismo_transito),
                        _buildDataRow('ID de Propietario', widget.id_propietario),
                        _buildDataRow('Nombre de Propietario', widget.nombre_propietario),
                        
                       
                        // Latitud y Longitud
                        if (latitude != null && longitude != null)
                          _buildDataRow('Latitud', latitude.toString()),
                        if (latitude != null && longitude != null)
                          _buildDataRow('Longitud', longitude.toString()),
                         _buildDataRow('Funcionario Inspector', user.name.toString()),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Botón para seleccionar fecha de ingreso
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                                fechaIngreso = "${picked.toLocal()}".split(' ')[0]; // Muestra solo la fecha
                              });
                            }
                          },
                          child: Text(
                            'Seleccionar Fecha de Ingreso',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Fecha de Ingreso: $fechaIngreso',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Botón para enviar inspección
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                        // Aquí puedes agregar la lógica para enviar la inspección
                      },
                      child: Text(
                        'Enviar Inspección',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinea al centro
      children: [
        Text(
          '$label',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ': $value',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ],
    );
  }
}
