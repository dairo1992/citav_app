import 'package:flutter/material.dart';
import '../widgets/drawer.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''),
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(Icons.menu), // Puedes usar el icono del Drawer o cualquier otro icono que desees
        onPressed: () {
          const DrawerPage();// Aquí puedes abrir el Drawer o realizar cualquier otra acción que necesites
        },
      iconSize: 36.0, // Ajusta el tamaño del icono a tu preferencia
      ),
      ),
      
      drawer: const DrawerPage(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                // Diseño para orientación vertical
                return _buildButtons(context);
              } else {
                // Diseño para orientación horizontal
                return _buildHorizontalButtons(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1, // Cambia el número de columnas aquí
      childAspectRatio: 2.5,
      mainAxisSpacing: 45.0,  
          
      children: [
        _roundedButton('assets/imageButton3.png', '/inspection', context, "Nueva \n Inspección"),
        _roundedButton('assets/imageButton3.png', '/my_inspections', context, "Inspecciones \n Realizadas"),
        // _roundedButton('assets/imageButton3.png', '/inspection', context, "Sincronizar"),
      ],
    );
  }

Widget _buildHorizontalButtons(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          crossAxisCount: 3, // Cambia el número de columnas aquí para la orientación horizontal
          childAspectRatio: 1.3,
          shrinkWrap: true, // Ajusta la altura automáticamente
          children: [
            _roundedButton('assets/imageButton3.png', '/inspection', context, "Nueva Inspección"),
            _roundedButton('assets/imageButton3.png', '/my_inspections', context, "Inspecciones Realizadas"),
            // _roundedButton('assets/imageButton3.png', '/inspection', context, "Sincronizar"),
          ],
        ),
      ],
    ),
  );
}


  Widget _roundedButton(String imageUrl, String pageRoute, BuildContext context, String buttonText) {
    return GestureDetector(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, pageRoute);
        },
        child: SizedBox(
          width: double.infinity,
          height: 280, // Establece la altura deseada
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(imageUrl),
              Text(
                buttonText,
                style: const TextStyle(
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
