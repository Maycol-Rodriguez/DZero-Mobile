import 'package:animate_do/animate_do.dart';
import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CasosReportadosScreen extends ConsumerWidget {
  static const String name = 'casos-screen';

  const CasosReportadosScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final respuestaAsync = ref.watch(obtenerReportesProvider);

    return Scaffold(
      appBar: AppBar(),
      body: FadeInUp(
        child: respuestaAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (reportes) {
            return RefreshIndicator(
              onRefresh: () => ref.refresh(obtenerReportesProvider.future),
              child: ListView.builder(
                itemCount: reportes.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        child: _DataContainer(reportes[index]),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DataContainer extends StatelessWidget {
  final Reporte reporte;
  const _DataContainer(this.reporte);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return Stack(
      children: [
        Container(
          decoration: CustomDecoration.decoration(false, true, false, true),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: CustomBorder.radiusTop,
                child: (reporte.picture == null)
                    ? const Image(
                        height: 230,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/no-image.png'),
                      )
                    : FadeInImage(
                        height: 230,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                        image: NetworkImage(reporte.picture!),
                      ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.description, size: 20),
                        Text('Descripción: ', style: textStyle!.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8, right: 20),
                      child: Text(
                        '${reporte.description}',
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                        style: textStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push('/reporte-detalle/${reporte.id}'),
              overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
              splashFactory: InkRipple.splashFactory,
              borderRadius: CustomBorder.radiusAll,
            ),
          ),
        ),
      ],
    );
  }
}
