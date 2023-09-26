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
          child: _buildButtons(context),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return ListView(
      children: [
        _roundedButton('assets/imageButton3.png', '/inspection', context, "Nueva Inspección"),
        _roundedButton('assets/imageButton3.png', '/my_inspections', context, "Inspecciones Realizadas"),
        _roundedButton('assets/imageButton3.png', '/my_inspections', context, "Sincronizar"),
      ],
    );
  }

  Widget _roundedButton(String imageUrl, String pageRoute, BuildContext context, String buttonText) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, pageRoute);
      },
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, pageRoute);
        },
        child: Container(
          width: double.infinity,
          height: 280, // Establece la altura deseada
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(imageUrl),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
