import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class VPerfilScreen extends ConsumerStatefulWidget {
  static const String name = 'perfil_screen';

  const VPerfilScreen({Key? key}) : super(key: key);

  @override
  VPerfilScreenState createState() => VPerfilScreenState();
}

class VPerfilScreenState extends ConsumerState<VPerfilScreen> {
  File? _image;
  String? path;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme.titleSmall;
    final usuario = ref.watch(usuarioAutenticado);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () => _showSelectPhotoOptions(context),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(150)),
                        child: usuario.photoURL != null
                            ? Image.network(
                                usuario.photoURL!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : _image == null
                                ? const Image(
                                    image: AssetImage('assets/images/avatar.png'),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    usuario.displayName!,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text('Usuario ID: ${usuario.uid.substring(0, 6)}...',
                      textAlign: TextAlign.center, style: textStyle),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.4,
                ),
                Positioned(
                  width: size.width,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.28,
                    decoration: CustomDecoration.decoration(true, false, true),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      child: Column(
                        children: [
                          _DatosWidget(
                            email: usuario.email!,
                            celular: usuario.phoneNumber,
                            nombre: usuario.displayName,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.edit),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      path = image.path;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      CloudinaryResponse response;
      try {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            path!,
            resourceType: CloudinaryResourceType.Image,
          ),
        );
      } on CloudinaryException catch (e) {
        throw (e.message!);
      }
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(response.secureUrl);

      setState(() {
        _image = img;
        context.pop();
      });
    } on PlatformException {
      context.pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: (source) async {
                _pickImage(source);
              },
            ),
          );
        },
      ),
    );
  }
}

class _DatosWidget extends StatelessWidget {
  final String email;
  final String? celular;
  final String? nombre;

  const _DatosWidget({
    required this.email,
    required this.nombre,
    required this.celular,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DatosPersonales(dato: email),
        const SizedBox(height: 12),
        _DatosPersonales(dato: celular ?? 'No añadio un telefono'),
        const SizedBox(height: 12),
        _DatosPersonales(dato: nombre ?? 'No añadio un nombre'),
      ],
    );
  }
}

class _DatosPersonales extends StatelessWidget {
  final String dato;
  const _DatosPersonales({
    required this.dato,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/icons/lista.png', width: 20),
        const SizedBox(width: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Expanded(
            child: Text(
              dato,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
