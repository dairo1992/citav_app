import 'package:flutter/material.dart';

import 'drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: DrawerPage(),
      body: Center(
        child: Text('¡Hola desde la página principal!'),
      ),
    );
  }
}
