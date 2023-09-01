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
            width: MediaQuery.of(context).size.width *
                0.9, // Ancho un poco más pequeño que la pantalla
            decoration: BoxDecoration(
              color: Colors.grey
                  .withOpacity(0.4), // Color de fondo gris translúcido
              borderRadius: BorderRadius.circular(10), // Bordes redondeados
            ),
            child: SingleChildScrollView(
              // Agregar un SingleChildScrollView
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/placa.png',
                          width: 350,
                          height: 350,
                        ),
                        Positioned(
                          left:
                              25, // Ajusta la posición horizontal del primer TextField
                          child: Container(
                            width: 150, // Ajusta el ancho del TextField
                            child: Text(
                              firstPart,
                              style: TextStyle(fontSize: 68, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          right:
                              2, // Ajusta la posición horizontal del segundo TextField
                          child: Container(
                            width: 150, // Ajusta el ancho del TextField
                            child: Text(
                              secondPart,
                               style: TextStyle(fontSize: 68, fontWeight: FontWeight.bold),
                            ),
                            ),
                          )
                        
                      ],
                    ),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Tipo vehiculo abandonado',
                      ),
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
                            controller: TextEditingController(
                                text: 'Coordenadas de ejemplo'),
                          ),
                        ),
                      ],
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
