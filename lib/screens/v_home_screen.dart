import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            const Separator('Bienvenido'),
            const UserDetailsWidget(),
            const SizedBox(height: 20),
            const Separator('Tus casos'),
            Expanded(child: UserCaseWidget(misCasos, ultimosCasos))
          ],
        ),
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
              decoration: decoration,
              child: data.when(
                data: (value) {
                  final ultimoReporte = dataList[0];
                  return Padding(
                    padding: const EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () => ref.read(routesProvider).pushNamed(VResultadosScreen.name),
                      child: UltimoCasoWidget(ultimoReporte: ultimoReporte),
                    ),
                  );
                },
                error: (error, __) => Center(child: Text('Error: $error')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Positioned(right: 20, top: 0, child: CameraWidget(size: size))
        ],
      ),
    );
  }
}
