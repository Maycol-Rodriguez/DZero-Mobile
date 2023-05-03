import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dzero/config/mappers/data_mapper_location.dart';
import 'package:dzero/config/services/cloudinary_service.dart';
import 'package:dzero/config/themes/colors_theme.dart';
import 'package:dzero/controllers/controllers.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/v_demo_data.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class VHomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';
  const VHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ContainerDetails(),
            ContainerSummary(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorSecondary,
        foregroundColor: Colors.white,
        onPressed: () {
          context.pushNamed(DemoDataScreen.name);
        },
        label: const Text('data'),
      ),
    );
  }
}

class ContainerDetails extends StatelessWidget {
  const ContainerDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            SizedBox(height: 30),
            _Separator('Bienvenido'),
            UserDetailsWidget(),
            SizedBox(height: 20),
            _Separator('Tus casos'),
            SizedBox(height: 20),
            Expanded(child: UserCaseWidget())
          ],
        ),
      ),
    );
  }
}

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
        if (pickedFile == null) {
          return;
        }

        try {
          CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              pickedFile.path,
              resourceType: CloudinaryResourceType.Image,
            ),
          );

          datos = DataMapperLocation(
            location: 'location aleatorio',
            description: 'Descripcion de prueba',
            picture: response.secureUrl,
            user: User(email: 'prueba@gmail.com', name: 'user-Prueba3'),
          );

          await ref.read(subirReportesProvider(datos).future);
          ref.read(obtenerReportesProvider.notifier).state =
              CDataProvider().obtenerReportes();

          setState(() {});
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

class ContainerSummary extends StatelessWidget {
  const ContainerSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
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
              height: size.height * 0.30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      backgroundColor: colorTerceary,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Ultimos Casos',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Miguel Perez',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'RCD Abandonados en ...',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(right: 20, top: 30, child: CameraWidget(size: size))
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  final String text;
  const _Separator(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
