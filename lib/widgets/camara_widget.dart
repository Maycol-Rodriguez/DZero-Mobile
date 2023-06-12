import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  @override
  Widget build(BuildContext context) {
    DataMapperLocation datos;
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

          datos = DataMapperLocation(
            id: uuid.v4(),
            location: 'Locacion de Muestra.',
            description: 'Descripcion de Muestra.',
            picture: response.secureUrl,
            user: User(email: 'user.email@gmail.com', name: 'usuario.name'),
          );
          ref.read(routesProvider).pushNamed(VResultadosScreen.name);
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
