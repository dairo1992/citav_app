import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NewInspection extends StatelessWidget {
  final String plateValue;

  NewInspection({required this.plateValue});

  @override
  Widget build(BuildContext context) {
    String firstPart = plateValue.substring(0, 3);
    String secondPart = plateValue.substring(3, 6);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Inspection'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Contenedor para datos fijos
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/placa.png',
                                width: 350,
                                height: 350,
                              ),
                              Positioned(
                                left: 25,
                                child: Container(
                                  width: 150,
                                  child: Text(
                                    firstPart,
                                    style: TextStyle(
                                        fontSize: 68, fontWeight: FontWeight.bold),
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
                                        fontSize: 68, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Text('Tipo de servicio: Particular'),
                          Text('Marca: Chevrolet'),
                          Text('Modelo: Swift'),
                          Text('Ubicación física: Coordenadas de ejemplo'),
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
      ),
    );
  }
}
