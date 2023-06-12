import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dzero/config/mappers/mappers.dart';
import 'package:dzero/config/routes/app_router.dart';
import 'package:dzero/config/services/cloudinary_service.dart';
import 'package:dzero/config/themes/colors_theme.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class VHomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';
  const VHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

    final data = ref.watch(obtenerReportesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: null,
      ),
      key: drawerKey,
      drawer: DrawerWidget(drawerKey),
      body: SafeArea(
        child: data.when(
          data: (value) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContainerDetails(value.length, value.length),
                ContainerSummary(data, value.reversed.toList()),
              ],
            );
          },
          error: (error, __) => Center(child: Text('Error: $error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class ContainerDetails extends StatelessWidget {
  final int misCasos;
  final int ultimosCasos;
  const ContainerDetails(
    this.misCasos,
    this.ultimosCasos, {
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
          children: <Widget>[
            const SizedBox(height: 5),
            const _Separator('Bienvenido'),
            const UserDetailsWidget(),
            const SizedBox(height: 20),
            const _Separator('Tus casos'),
            Expanded(child: UserCaseWidget(misCasos, ultimosCasos))
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

class ContainerSummary extends ConsumerWidget {
  final AsyncValue<List<DataMapperLocation>> data;
  final List<DataMapperLocation> dataList;

  const ContainerSummary(
    this.data,
    this.dataList, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                height: size.height * 0.28,
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
                child: data.when(
                  data: (value) {
                    final newData = dataList[0];
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: GestureDetector(
                        onTap: () => ref
                            .read(routesProvider)
                            .pushNamed(VResultadosScreen.name),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: colorTerceary,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Ultimo Caso',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              newData.user.name,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              newData.description ?? 'descripcion',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  error: (error, __) => Center(child: Text('Error: $error')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                )),
          ),
          Positioned(right: 20, top: 0, child: CameraWidget(size: size))
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
