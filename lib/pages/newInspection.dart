import 'package:flutter/material.dart';

class NewInspection extends StatelessWidget {
  final String plateValue;

  NewInspection({required this.plateValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Inspection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'PLACA DEL VEHICULO A INSPECCIONAR:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextField(
              textAlign: TextAlign.center,
              readOnly: true,
              controller: TextEditingController(text: plateValue),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 16), // Espacio entre campos
            TextField(
              decoration: InputDecoration(
                labelText: 'Tipo vehiculo abandonado',
              ),
            ),
            SizedBox(height: 8), // Espacio entre campos
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Ubicacion fisica',
                      suffixIcon: Icon(Icons.location_on),
                    ),
                    readOnly: true,
                    controller: TextEditingController(text: 'Coordenadas de ejemplo'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8), // Espacio entre campos
            TextField(
              decoration: InputDecoration(
                labelText: 'Tipo de servicio',
              ),
              readOnly: true,
              controller: TextEditingController(text: 'Particular'),
            ),
            SizedBox(height: 8), // Espacio entre campos
            TextField(
              decoration: InputDecoration(
                labelText: 'Marca',
              ),
              readOnly: true,
              controller: TextEditingController(text: 'Chevrolet'),
            ),
            SizedBox(height: 8), // Espacio entre campos
            TextField(
              decoration: InputDecoration(
                labelText: 'Modelo',
              ),
              readOnly: true,
              controller: TextEditingController(text: 'Swift'),
            ),
          ],
        ),
      ),
    );
  }
}
