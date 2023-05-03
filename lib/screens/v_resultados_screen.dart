import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:dzero/config/themes/colors_theme.dart';
import 'package:flutter/material.dart';

class VResultadosScreen extends StatelessWidget {
  static const String name = 'resultados_screen';

  const VResultadosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: _GraficoCircular(),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.5,
                  children: const [
                    _CardDetalle(
                      tipo: 'RCD',
                      porcentaje: '35%',
                      icono: '',
                      color: Colors.blue,
                    ),
                    _CardDetalle(
                      tipo: 'Plastico',
                      porcentaje: '8%',
                      icono: '',
                      color: Colors.blue,
                    ),
                    _CardDetalle(
                      tipo: 'Metal',
                      porcentaje: '5%',
                      icono: '',
                      color: Colors.blue,
                    ),
                    _CardDetalle(
                      tipo: 'Papel',
                      porcentaje: '5%',
                      icono: '',
                      color: Colors.blue,
                    ),
                    _CardDetalle(
                      tipo: 'Madera',
                      porcentaje: '35%',
                      icono: '',
                      color: Colors.blue,
                    ),
                    _CardDetalle(
                      tipo: 'Carton',
                      porcentaje: '12%',
                      icono: '',
                      color: Colors.blue,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GraficoCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> chartKey =
        GlobalKey<AnimatedCircularChartState>();
    return AnimatedCircularChart(
      key: chartKey,
      size: const Size(300.0, 300.0),
      startAngle: 90,
      initialChartData: const <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
              90,
              colorTerceary,
              rankKey: 'completed',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
      holeLabel: '90',
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 60.0,
      ),
    );
  }
}

class _CardDetalle extends StatelessWidget {
  final String tipo;
  final String porcentaje;
  final String icono;
  final Color color;

  const _CardDetalle({
    required this.tipo,
    required this.porcentaje,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 15,
            ),
            const SizedBox(height: 5),
            Text(
              tipo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              porcentaje,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
