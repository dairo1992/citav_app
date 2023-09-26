import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/user.dart';
import '../pages/login.dart';
import '../widgets/appTheme.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.asentColor1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                    height: 5), // Espacio entre la imagen y el texto adicional
                Text(
                  user.name.toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title:
                Text('Inicio', style: AppTheme.lightTheme.textTheme.bodyLarge),
            onTap: () {
              Navigator.of(context).pop(); // Cerrar el Drawer
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.sync),
            title: Text('Sincronizar'),
            onTap: () {
              // Lógica para sincronizar
              Navigator.of(context).pop(); // Cerrar el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Nueva Inspección'),
            onTap: () {
              Navigator.of(context).pop(); // Cerrar el Drawer
              Navigator.pushNamed(context, '/inspection');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Inspec. Realizadas'),
            onTap: () {
              Navigator.of(context).pop(); // Cerrar el Drawer
              Navigator.pushNamed(context, '/my_inspections');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.of(context).pop(); // Cerrar el Drawer
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Ayuda'),
            onTap: () {
              Navigator.of(context).pop(); // Cerrar el Drawer
              Navigator.pushNamed(context, '/help');
            },
          ),

          SizedBox(height: 50),
          Divider(), // Línea divisora
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              // Lógica para cerrar sesión
              Navigator.of(context).pop(); // Cerrar el Drawer
              // Navegar a la página de login, asegurándonos de que no se pueda volver atrás
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
