import 'package:flutter/material.dart';

import 'drawer.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      drawer: DrawerPage(),
      body: Center(
        child: Text('¡Hola desde la página del perfil!'),
      ),
    );
  }
}
