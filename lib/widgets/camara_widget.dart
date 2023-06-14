import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CameraWidget extends ConsumerStatefulWidget {
  const CameraWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  CameraWidgetState createState() => CameraWidgetState();
}

class CameraWidgetState extends ConsumerState<CameraWidget> {
  final db = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    Reporte datos;
    const uuid = Uuid();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorTerceary,
        foregroundColor: Colors.white,
        minimumSize: const Size(30, 55),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onPressed: () async {
        final picker = ImagePicker();
        final XFile? pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 30,
        );
        if (pickedFile == null) return;
        try {
          CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              pickedFile.path,
              resourceType: CloudinaryResourceType.Image,
            ),
          );

          datos = Reporte(
            id: '',
            picture: response.secureUrl,
            description: 'descripcion de prueba',
            location: '-12.04807041556919, -75.18945304764888',
            user: User(
              id: uuid.v1(),
              email: 'email@prueba.com',
              name: 'usuario de prueba',
            ),
          );

          context.pushNamed(VResultadosScreen.name);
          ref.read(subirReportesProvider(datos));
          ref.invalidate(obtenerReportesProvider);
        } on CloudinaryException catch (e) {
          Text(e.message ?? '');
        }
      },
      child: const Icon(
        Icons.camera_alt,
        size: 30,
      ),
    );
  }
}
