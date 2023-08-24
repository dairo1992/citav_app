import 'dart:convert';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String apiUrl = 'https://ibingcode.com/public/login';

    final Map<String, dynamic> data = {
      'username': _userController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Error de inicio de sesión',
                style: TextStyle(fontSize: 24),
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Usuario o contraseña incorrectos.',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        // Mostrar diálogo de error de conexión con la API
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error de conexión'),
            content: Text('No se pudo conectar con el servidor.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Aceptar',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Error de conexión con la API
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error de conexión'),
          content: Text('No se pudo conectar con el servidor.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Aceptar',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(182, 179, 179, 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 250,
                    height: 250,
                  ),
                  TextFormField(
                    controller: _userController,
                    decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: TextStyle(fontSize: 25),
                        hintStyle: TextStyle(fontSize: 50),
                        
                    ),
                        
                    style: TextStyle(
                      fontSize: 40,
                    ),
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
                    width: 15,
                    child: ElevatedButton(
                      onPressed: () => _login(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        textStyle: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      child: Text('Iniciar sesión'),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
