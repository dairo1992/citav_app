import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      drawer: DrawerPage(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OrientationBuilder(
                builder: (context, orientation) {
                  return _buildButtons(orientation, context);
                },
              ),
              // Resto del contenido de la pantalla
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(Orientation orientation, BuildContext context) {
    final buttonSpacingFactor = 0.06; // Factor de separación
    final buttonSize = 300.0; // Tamaño de los botones

    final screenWidth = MediaQuery.of(context).size.width;

    return orientation == Orientation.portrait
        ? Column(
            children: [
              _roundedButton('assets/imageButton3.png', buttonSize, '/inspection', context, "Nueva Inspeccion"),
              SizedBox(height: screenWidth * buttonSpacingFactor),
              _roundedButton('assets/imageButton3.png', buttonSize, '/my_inspections', context, "Inspecciones Realizadas"),
             SizedBox(height: screenWidth * buttonSpacingFactor),
              _roundedButton('assets/imageButton3.png', buttonSize, '/my_inspections', context, "Sincronizar"),
            
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _roundedButton('assets/imageButton3.png', buttonSize, '/inspection', context, "Nueva Inspeccion"),
              SizedBox(width: screenWidth * buttonSpacingFactor),
              _roundedButton('assets/imageButton3.png', buttonSize, '/my_inspections', context, "Inspecciones Realizadas"),
              SizedBox(width: screenWidth * buttonSpacingFactor),
              _roundedButton('assets/imageButton3.png', buttonSize, '/my_inspections', context, "Sincronizar"),
            
            ],
          );
  }

  Widget _roundedButton(String imageUrl, double size, String pageRoute, BuildContext context, String buttonText) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, pageRoute);
      },
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, pageRoute);
        },
        child: Container(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(imageUrl, width: size * 1, height: size * 1),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
