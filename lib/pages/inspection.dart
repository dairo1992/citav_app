import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'newInspection.dart';
import '../widgets/appTheme.dart';

  final FocusNode _textFieldFocusNode = FocusNode();

class InspectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: NewInspectionPage(),
      routes: {
        '/newInspection': (context) => NewInspection(
            plateValue: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}

class NewInspectionPage extends StatefulWidget {
  @override
  _NewInspectionPageState createState() => _NewInspectionPageState();
}

class _NewInspectionPageState extends State<NewInspectionPage> {
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

  
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/placa.png',
              width: 350,
              height: 350,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: 450,
                  child: TextField(
                    controller: _plateController,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6), // Limita a 6 caracteres
                      UpperCaseTextFormatter(), // Convierte a mayúsculas
                    ],
                    focusNode: primaryFocus,
                    decoration: InputDecoration(
                      hintText: 'INGRESE LA PLACA DEL VEHICULO',
                    ),
                    style: AppTheme().bodyLargeStyle,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: AppTheme().buttonLightStyle,
              onPressed: _navigateToNewInspection,
              child: Text('Inspeccionar', style: AppTheme().textButton1),
            ),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
