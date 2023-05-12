import 'package:dzero/config/mappers/data_mapper_location.dart';
import 'package:dzero/config/themes/colors_theme.dart';
import 'package:dzero/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VDemoDataScreen extends ConsumerWidget {
  static const String name = 'casos_screen';

  const VDemoDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<DataMapperLocation> data = [];

    Future<List<DataMapperLocation>> dataList() async {
      data = await ref.watch(obtenerReportesProvider);
      return data.reversed.toList();
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: dataList(),
        initialData: data.reversed.toList(),
        builder: (context, AsyncSnapshot<List<DataMapperLocation>> snapshot) {
          final newData = snapshot.data;
          return ListView.builder(
            itemCount: newData!.length,
            itemBuilder: (context, int index) {
              return Container(
                margin: const EdgeInsets.all(20),
                height: 380,
                width: double.infinity,
                child: _DataContainer(newData[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class _DataContainer extends StatelessWidget {
  final DataMapperLocation data;
  const _DataContainer(this.data);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorSecondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: data.picture == null
                ? const Image(
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/presets/no-image.png'),
                  )
                : FadeInImage(
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder:
                        const AssetImage('assets/presets/jar-loading.gif'),
                    image: NetworkImage(data.picture!),
                  ),
          ),
          const SizedBox(height: 15),
          Flexible(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Usuario: ',
                        style: textStyle!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(data.user.name, style: textStyle),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.description,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Descripción: ',
                        style: textStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      '${data.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: textStyle,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
