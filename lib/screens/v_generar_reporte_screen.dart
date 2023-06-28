import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GenerarReporteScreen extends ConsumerStatefulWidget {
  static const String name = 'generar-reporte';
  const GenerarReporteScreen({Key? key}) : super(key: key);

  @override
  GenerarReporteScreenState createState() => GenerarReporteScreenState();
}

class GenerarReporteScreenState extends ConsumerState<GenerarReporteScreen> {
  File? _image;
  String? path;
  User? usuario;
  String descripcion = '';

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(loadingProvider);
    final formReporte = ref.watch(formularioReporteProvider);
    usuario = ref.watch(usuarioAutenticado);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 450,
                          width: double.infinity,
                          decoration: CustomDecoration.decoration(false, true, false, false, true),
                          child: Opacity(
                            opacity: .75,
                            child: ClipRRect(
                              borderRadius: CustomBorder.radiusTop,
                              child: _image == null
                                  ? const Image(
                                      image: AssetImage('assets/images/no-image.png'),
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
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 20,
                    child: IconButton(
                      onPressed: () => context.pushReplacementNamed(VHomeScreen.name),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: CustomDecoration.decoration(false),
                  child: Form(
                    key: ref.watch(formularioReporteProvider).formReportKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          maxLines: 3,
                          minLines: 1,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => descripcion = value,
                          decoration: InputDecorations.authInputDecoration(
                            labelText: 'Descripcion',
                            hintText: 'Descripcion del reporte ',
                            prefixIcon: Icons.description,
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return 'La descripcion es obligatoria';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(loader ? 'Enviando....' : 'Enviar reporte'),
        icon: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.transparent,
          child: loader
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.save_outlined, color: Colors.white),
        ),
        extendedIconLabelSpacing: 15,
        onPressed: loader
            ? null
            : () async {
                if (_image == null) {
                  mostrarSnackBar(context, 'Seleccione una imagen');
                  return;
                }
                if (!formReporte.reporteEsValido()) return;
                formReporte.reporteEsValido();
                ref.read(loadingProvider.notifier).state = true;
                await _enviarReporte();
                ref.read(loadingProvider.notifier).state = false;
                ref.invalidate(obtenerReportesProvider);

                Future.delayed(const Duration(milliseconds: 50), () {
                  context.pushReplacementNamed(VHomeScreen.name);
                  mostrarSnackBar(context, 'Enviado satisfactoriamente');
                });
              },
      ),
    );
  }

  Future<void> _enviarReporte() async {
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

    final reporte = Reporte(
      id: '',
      picture: response.secureUrl,
      description: descripcion,
      location: '-18.04807041556919, -95.18945304764888',
      user: UserReporte(
        id: usuario!.uid,
        email: usuario!.email!,
        name: usuario!.displayName!,
      ),
    );
    await ref.read(subirReportesProvider(reporte).future);
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      path = image.path;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
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
              onTap: _pickImage,
            ),
          );
        },
      ),
    );
  }
}
