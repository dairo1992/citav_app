import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    // Verificar el usuario y la contraseña (valores de prueba)
    if (_userController.text == 'afem' && _passwordController.text == '123') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error de inicio de sesión'),
          content: Text('Usuario o contraseña incorrectos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/login_bg.png'), // Ruta de la imagen de fondo
            fit: BoxFit.cover, // Ajusta la imagen para que cubra el fondo
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(182, 179, 179,
                    0.5), // Color de fondo gris para el contenedor interno
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/logo.png', // Ruta de la imagen
                    width: 250, // Ajusta el ancho de la imagen
                    height: 250,
                  ),
                  TextFormField(
                    controller: _userController,
                    decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: TextStyle(fontSize: 25),
                        hintStyle: TextStyle(fontSize: 50)),

                    style: TextStyle(
                        fontSize: 40), // Ajusta el tamaño del texto ingresado
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(fontSize: 25),
                    ),
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 90, vertical: 0),
                    padding: EdgeInsets.all(20),
                    width: 15, // Ajusta el ancho del botón
                    child: ElevatedButton(
                      onPressed: () => _login(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 20), // Ajusta el padding vertical
                        textStyle: TextStyle(
                            fontSize: 35), // Ajusta el tamaño del texto
                      ),
                      child: Text('Iniciar sesión'),
                    ),
                  ),
                  SizedBox(height: 20), // Espacio entre el botón y la imagen
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
