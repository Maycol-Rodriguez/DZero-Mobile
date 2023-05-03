import 'package:dzero/config/mappers/data_mapper_location.dart';
import 'package:dzero/config/themes/colors_theme.dart';
import 'package:dzero/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VDemoDataScreen extends ConsumerWidget {
  static const String name = 'demo_data_screen';

  const VDemoDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<DataMapperLocation> data = [];

    Future<List<DataMapperLocation>> dataList() async {
      data = await ref.watch(obtenerReportesProvider);
      return data;
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: dataList(),
        initialData: data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(20),
                height: 380,
                width: double.infinity,
                child: _DataContainer(data[index]),
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
                children: [
                  Text(
                    data.location ?? 'No location',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${data.user.name} ${data.user.email}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      data.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
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
