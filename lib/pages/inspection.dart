import 'package:flutter/material.dart';
import 'newInspection.dart';

class InspectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
   routes: {
  '/newInspection': (context) => NewInspection(plateValue: ModalRoute.of(context)!.settings.arguments as String),
},

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _plateController = TextEditingController();
  
  void _navigateToNewInspection() {
    Navigator.pushNamed(
      context,
      '/newInspection',
      arguments: _plateController.text,
    );
  }

  @override
  void dispose() {
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _plateController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'PLACA del vehiculo',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToNewInspection,
              child: Text('Inspeccionar'),
            ),
          ],
        ),
      ),
    );
  }
}
