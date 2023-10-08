// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:citav_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../entities/user.dart';

class NewInspection extends StatefulWidget {
  final String plateValue;
  final String modelo;
  final String numeroChasis;
  final String numeroMotor;
  final String marca;
  final String tipoServicio;
  final String tipoVehiculo;
  final String organismoTransito;
  final String idPropietario;
  final String nombrePropietario;

  const NewInspection({super.key, 
    required this.plateValue,
    required this.modelo,
    required this.numeroChasis,
    required this.numeroMotor,
    required this.marca,
    required this.tipoServicio,
    required this.tipoVehiculo,
    required this.organismoTransito,
    required this.idPropietario,
    required this.nombrePropietario,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NewInspectionState createState() => _NewInspectionState();
}

class _NewInspectionState extends State<NewInspection> {
  Location location = Location();
  double? latitude;
  double? longitude;
  DateTime? selectedDate; // Variable para almacenar la fecha seleccionada
  String fechaIngreso = ""; // Variable para mostrar la fecha en el cuadro de diálogo

  List<File?> photos = List.generate(4, (_) => null); // Lista para almacenar las fotos
  List<FileInfo?> photosInfo = List.generate(4, (_) => null); // Información de las fotos

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

  // Método para tomar una foto
  Future<void> _takePhoto(int photoIndex) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      // Obtener información de la foto
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

  // Método para mostrar una foto tomada
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
              style: const TextStyle(fontSize: 16),
            ),
          ),
        if (fileInfo != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Peso: ${fileInfo.sizeInKB.toStringAsFixed(2)} KB',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        if (fileInfo != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Dimensiones: ${fileInfo.dimensions}',
              style: const TextStyle(fontSize: 16),
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

    TextStyle textStyle = const TextStyle(fontSize: 25.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Inspection', style: textStyle),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Imagen de la placa y texto
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
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          firstPart,
                          style: const TextStyle(
                            fontSize: 68,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          secondPart,
                          style: const TextStyle(
                            fontSize: 68,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Contenedor para datos fijos
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDataRow('Tipo de servicio', widget.tipoServicio),
                      _buildDataRow('Marca', widget.marca),
                      _buildDataRow('Modelo', widget.modelo),
                      _buildDataRow('Número de Chasis', widget.numeroChasis),
                      _buildDataRow('Número de Motor', widget.numeroMotor),
                      _buildDataRow('Tipo de Vehículo', widget.tipoVehiculo),
                      _buildDataRow('Organismo de Tránsito', widget.organismoTransito),
                      _buildDataRow('ID de Propietario', widget.idPropietario),
                      _buildDataRow('Nombre de Propietario', widget.nombrePropietario),

                      // Latitud y Longitud
                      if (latitude != null && longitude != null)
                        _buildDataRow('Latitud', latitude.toString()),
                      if (latitude != null && longitude != null)
                        _buildDataRow('Longitud', longitude.toString()),
                      _buildDataRow('Funcionario Inspector', user.name.toString()),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Botón para seleccionar fecha de ingreso
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                              fechaIngreso = "${picked.toLocal()}".split(' ')[0]; // Muestra solo la fecha
                            });
                          }
                        },
                        child: const Text(
                          'Seleccionar Fecha de Ingreso',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Fecha de Ingreso: $fechaIngreso',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Botón para enviar inspección
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                      // Aquí puedes agregar la lógica para enviar la inspección
                    },
                    child: const Text(
                      'Enviar Inspección',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Espacios para tomar fotos
                Column(
                  children: [
                    for (int i = 0; i < 4; i++)
                      Column(
                        children: [
                          Text('Foto ${i + 1}', style: textStyle),
                          _buildPhoto(i),
                          const SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              ],
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
          label,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ': $value',
          style: const TextStyle(
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
