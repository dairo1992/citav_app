import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../entities/user.dart';
import 'home.dart';

class AtypicalInspection extends StatefulWidget {
  final String plateValue;

  AtypicalInspection({
    required this.plateValue,
  });

  @override
  _AtypicalInspectionState createState() => _AtypicalInspectionState();
}

class _AtypicalInspectionState extends State<AtypicalInspection> {
  Location location = Location();
  double? latitude;
  double? longitude;
  DateTime? selectedDate; // Variable para almacenar la fecha seleccionada
  String fechaIngreso = ""; // Variable para mostrar la fecha en el cuadro de diálogo

  List<File?> photos = List.generate(4, (_) => null); // Lista para almacenar las fotos
  List<FileInfo?> photosInfo = List.generate(4, (_) => null); // Información de las fotos

  String selectedVehicleType = 'Automovil'; // Valor por defecto
  String selectedCarBrand = 'Toyota'; // Valor por defecto

  List<String> vehicleTypes = [
    'Automovil',
    'Camioneta',
    'Bus',
    'TractoCamion',
    'Motocicleta',
  ];

  List<String> carBrands = [
    'Toyota',
    'Honda',
    'Ford',
    'Chevrolet',
    'Nissan',
    // Agrega aquí las demás marcas de carros
  ];

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locationData = await location.getLocation();
    if (mounted) {
      setState(() {
        latitude = _locationData.latitude;
        longitude = _locationData.longitude;
      });
    }
  }

  Future<void> _takePhoto(int photoIndex) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      final int fileSizeInBytes = imageFile.lengthSync();
      final double fileSizeInKB = fileSizeInBytes / 1024.0;
      final String imageDimensions =
          '${imageFile.readAsBytesSync().lengthInBytes}x${imageFile.readAsBytesSync().lengthInBytes}';

      final FileInfo fileInfo = FileInfo(
        file: imageFile,
        sizeInKB: fileSizeInKB,
        dimensions: imageDimensions,
      );

      setState(() {
        photos[photoIndex] = imageFile;
        photosInfo[photoIndex] = fileInfo;
      });
    }
  }

  Widget _buildPhoto(int photoIndex) {
    final photo = photos[photoIndex];
    final fileInfo = photosInfo[photoIndex];

    return Column(
      children: [
        photo != null
            ? Image.file(
                photo,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : ElevatedButton(
                onPressed: () => _takePhoto(photoIndex),
                child: Text('Tomar Foto $photoIndex'),
              ),
        if (fileInfo != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Formato: ${fileInfo.file.path.split('.').last}',
              style: TextStyle(fontSize: 16),
            ),
          ),
        if (fileInfo != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Peso: ${fileInfo.sizeInKB.toStringAsFixed(2)} KB',
              style: TextStyle(fontSize: 16),
            ),
          ),
        if (fileInfo != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Dimensiones: ${fileInfo.dimensions}',
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String firstPart = widget.plateValue.substring(0, 3);
    String secondPart = widget.plateValue.substring(3, 6);
    final user = Provider.of<User>(context);

    TextStyle textStyle = TextStyle(fontSize: 25.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inspeccion sin registro previo', style: textStyle),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/placa.png',
                        width: 350,
                        height: 200,
                      ),
                      Positioned(
                        left: 25,
                        child: Container(
                          width: 150,
                          child: Text(
                            firstPart,
                            style: TextStyle(
                              fontSize: 68,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        child: Container(
                          width: 150,
                          child: Text(
                            secondPart,
                            style: TextStyle(
                              fontSize: 68,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        if (latitude != null && longitude != null)
                          _buildDataRow('Latitud', latitude.toString()),
                        if (latitude != null && longitude != null)
                          _buildDataRow('Longitud', longitude.toString()),
                        _buildDataRow('Funcionario Inspector', user.name.toString()),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Agregar lista desplegable para el tipo de vehículo
                        DropdownButton<String>(
                          isExpanded: true,
                          value: selectedVehicleType,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedVehicleType = newValue!;
                            });
                          },
                          items: vehicleTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                        ),

                        // Agregar lista desplegable para la marca del automóvil
                        DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCarBrand,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCarBrand = newValue!;
                            });
                          },
                          items: carBrands.map((String brand) {
                            return DropdownMenuItem<String>(
                              value: brand,
                              child: Text(brand),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Text(
                        'Enviar Inspección',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Column(
                          children: [
                            Text('Foto ${i + 1}', style: textStyle),
                            _buildPhoto(i),
                            SizedBox(height: 16),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinea al centro
      children: [
        Text(
          '$label',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ': $value',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ],
    );
  }
}

class FileInfo {
  final File file;
  final double sizeInKB;
  final String dimensions;

  FileInfo({
    required this.file,
    required this.sizeInKB,
    required this.dimensions,
  });
}
