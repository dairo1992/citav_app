import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'newInspection.dart';
import '../widgets/appTheme.dart';

class FindPlatePage extends StatefulWidget {
  @override
  _FindPlatePageState createState() => _FindPlatePageState();
}

class _FindPlatePageState extends State<FindPlatePage> {
  TextEditingController _plateController = TextEditingController();
  bool _isPlateEmpty = true;

void _navigateToNewInspection() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => NewInspection(plateValue: _plateController.text),
    ),
  );
}

  @override
  void initState() {
    super.initState();
    _plateController.addListener(_updatePlateEmptyStatus);
  }

  void _updatePlateEmptyStatus() {
    setState(() {
      _isPlateEmpty = _plateController.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    _plateController.removeListener(_updatePlateEmptyStatus);
    _plateController.dispose();
    super.dispose();
  }

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
              onPressed: _isPlateEmpty ? null : _navigateToNewInspection,
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
