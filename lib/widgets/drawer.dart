import 'package:flutter/material.dart';

import '../pages/login.dart';
import '../widgets/appTheme.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme
                  .asentColor1, // Utiliza el color primario definido en el ThemeData
            ),
            child: Center(
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio',
                          style: AppTheme.lightTheme.textTheme.bodyLarge),
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
