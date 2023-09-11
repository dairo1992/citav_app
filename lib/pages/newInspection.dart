import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NewInspection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    String firstPart = plateValue.substring(0, 3);
    String secondPart = plateValue.substring(3, 6);

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
                        _buildDataRow('Tipo de servicio', tipo_servicio),
                        _buildDataRow('Marca', marca),
                        _buildDataRow('Modelo', modelo),
                        _buildDataRow('Número de Chasis', numero_chasis),
                        _buildDataRow('Número de Motor', numero_motor),
                        _buildDataRow('Tipo de Vehículo', tipo_vehiculo),
                        _buildDataRow('Organismo de Tránsito', organismo_transito),
                        _buildDataRow('ID de Propietario', id_propietario),
                        _buildDataRow('Nombre de Propietario', nombre_propietario),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Contenedor para campos editables
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Tipo vehículo abandonado',
                          ),
                          style: textStyle,
                        ),
                        SizedBox(height: 8),
                        // Otros campos editables aquí
                      ],
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
