import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomar y Subir Foto a FTP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoUploaderScreen(),
    );
  }
}

class PhotoUploaderScreen extends StatefulWidget {
  @override
  _PhotoUploaderScreenState createState() => _PhotoUploaderScreenState();
}

class _PhotoUploaderScreenState extends State<PhotoUploaderScreen> {
  final FTPConnect _ftpConnect = FTPConnect(
    "ftp.ibingcode.com",
    user: "u793589645.citav_multimedia",
    pass: "Recaudos123#",
  );

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _log(String log) async {
    print(log);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> _uploadPhotoToFTP(File imageFile) async {
    try {
      await _log('Connecting to FTP ...');
      await _ftpConnect.connect();
      await _log('Uploading ...');
      await _ftpConnect.changeDirectory('upload');

      // Genera un nombre de archivo único (puedes personalizar esto)
      String fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Sube el archivo al servidor FTP
      await _ftpConnect.uploadFile(imageFile, sRemoteName: fileName);

      await _log('File uploaded successfully');
    } catch (e) {
      await _log('Error: ${e.toString()}');
    } finally {
      await _ftpConnect.disconnect();
    }
  }

  Future<void> _takeAndUploadPhoto() async {
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
      maxWidth: 1920,
      maxHeight: 1080,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (imageFile != null) {
      // Corrige la orientación de la imagen antes de mostrarla
      final image = img.decodeImage(File(imageFile.path).readAsBytesSync())!;
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_image.jpg');

      // Guarda la imagen corregida en el archivo temporal
      tempFile.writeAsBytesSync(Uint8List.fromList(img.encodeJpg(image)));

      // Sube la imagen al servidor FTP
      await _uploadPhotoToFTP(tempFile);

      setState(() {
        _imageFile = tempFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar y Subir Foto a FTP'),
      ),
      body: Center(
        child: _imageFile == null
            ? Text('No has tomado una foto.')
            : Image.file(_imageFile!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takeAndUploadPhoto,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
