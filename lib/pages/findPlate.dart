import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'newInspection.dart';
import '../widgets/appTheme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FindPlatePage extends StatefulWidget {
  @override
  _FindPlatePageState createState() => _FindPlatePageState();
}

class _FindPlatePageState extends State<FindPlatePage> {
  TextEditingController _plateController = TextEditingController();
  bool _isPlateEmpty = true;

  void _navigateToNewInspection() async {
    final plate = _plateController.text;

    try {
      // Realizar la solicitud POST a la API
      final response = await http.post(
        Uri.parse('https://ibingcode.com/public/infovehiculo'),
        body: '{"placa": "$plate"}',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          // Mostrar el mensaje cuando no se encuentren datos
          _showErrorMessage(
              'Vehículo no encontrado en la base de datos del RUNT.');
        } else {
          final List<dynamic> data = json.decode(response.body);

          if (data.isNotEmpty) {
            final Map<String, dynamic> vehicleData = data[0];

            String modelo = vehicleData['v.modelo'];
            String numero_chasis = vehicleData['numero_chasis'];
            String numero_motor = vehicleData['numero_motor'];
            String marca = vehicleData['marca'];
            String tipo_servicio = vehicleData['tipo_servicio'];
            String tipo_vehiculo = vehicleData['tipo_vehiculo'];
            String organismo_transito = vehicleData['organismo_transito'];
            String id_propietario = vehicleData['id_propietario'].toString();
            String nombre_propietario = vehicleData['nombre_propietario'];

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NewInspection(
                    plateValue: plate,
                    modelo: modelo,
                    numero_chasis: numero_chasis,
                    numero_motor: numero_motor,
                    marca: marca,
                    tipo_servicio: tipo_servicio,
                    tipo_vehiculo: tipo_vehiculo,
                    organismo_transito: organismo_transito,
                    id_propietario: id_propietario,
                    nombre_propietario: nombre_propietario),
              ),
            );
          } else {
            _showErrorMessage(
                'Vehículo no encontrado en la base de datos del RUNT.');
          }
        }
      } else {
        _showErrorMessage(
            'No se pudo obtener información del vehículo. Sin conexión con el servidor.');
      }
    } catch (e) {
      _showErrorMessage(
          'Error al comunicarse con el servidor. Verifique su conexión a internet.'+e.toString());
    }
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error', style: TextStyle(fontSize: 25.0)),
        content: Text(message, style: TextStyle(fontSize: 25.0)),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar', style: TextStyle(fontSize: 25.0)),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra la ventana emergente
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _plateController.addListener(_updatePlateEmptyStatus);
  }

  void _updatePlateEmptyStatus() {
    setState(() {
      _isPlateEmpty = _plateController.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    _plateController.removeListener(_updatePlateEmptyStatus);
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: 450,
                  child: TextField(
                    controller: _plateController,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      UpperCaseTextFormatter(),
                    ],
                    focusNode: primaryFocus,
                    decoration: InputDecoration(
                      hintText: 'INGRESE LA PLACA DEL VEHÍCULO',
                    ),
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: AppTheme().buttonLightStyle,
              onPressed: _isPlateEmpty ? null : _navigateToNewInspection,
              child: Text('Inspeccionar', style: TextStyle(fontSize: 25.0)),
            ),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
