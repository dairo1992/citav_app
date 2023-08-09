import 'package:flutter/material.dart';

import 'drawer.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help')),
      drawer: DrawerPage(),
      body: Center(
        child: Text('¡Hola desde la página de ayuda!'),
      ),
    );
  }
}
