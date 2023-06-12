import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:dzero/config/config.dart';
import 'package:flutter/material.dart';

class GraficoCircular extends StatelessWidget {
  const GraficoCircular({super.key});

  @override
  Widget build(BuildContext context) {
    final chartKey = GlobalKey<AnimatedCircularChartState>();
    return AnimatedCircularChart(
      key: chartKey,
      size: const Size(300, 300),
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
        fontSize: 90.0,
      ),
    );
  }
}
