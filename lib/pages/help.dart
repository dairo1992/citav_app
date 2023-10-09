// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:zlib/zlib.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Capturar Imagen y Convertirla a Base64',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PhotoConverterScreen(),
//     );
//   }
// }

// class PhotoConverterScreen extends StatefulWidget {
//   @override
//   _PhotoConverterScreenState createState() => _PhotoConverterScreenState();
// }

// class _PhotoConverterScreenState extends State<PhotoConverterScreen> {
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   void _captureAndConvertImage() async {
//     final XFile? imageFile = await _picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 90,
//       maxWidth: 1920,
//       maxHeight: 1080,
//       preferredCameraDevice: CameraDevice.rear,
//     );

//     if (imageFile != null) {
//       setState(() {
//         _imageFile = File(imageFile.path);
//       });

//       // Convierte la imagen a base64
//       final List<int> imageBytes = await _imageFile!.readAsBytes();
//       final String base64Image = base64Encode(imageBytes);

//       // Comprime el código Base64 utilizando zlib
//       final codec = ZLibCodec();
//       final compressedBytes = codec.encode(utf8.encode(base64Image));
//       final compressedBase64 = base64Encode(compressedBytes);

//       // Descomprime el código Base64
//       final decompressedBytes = codec.decode(base64Decode(compressedBase64));
//       final decompressedBase64 = utf8.decode(decompressedBytes);

//       // Muestra el JSON con el código Base64 comprimido en pantalla
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Imagen en Base64 Comprimido'),
//             content: SingleChildScrollView(
//               child: Text(decompressedBase64),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Cerrar'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Capturar Imagen y Convertirla a Base64'),
//       ),
//       body: Center(
//         child: _imageFile == null
//             ? Text('No has capturado una imagen.')
//             : Image.file(_imageFile!),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _captureAndConvertImage,
//         child: const Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }
