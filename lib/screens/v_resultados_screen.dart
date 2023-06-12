import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';

class VResultadosScreen extends StatelessWidget {
  static const String name = 'resultados_screen';

  const VResultadosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 350,
                child: GraficoCircular(),
              ),
              const SizedBox(height: 20),
              GridView.count(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.6,
                children: const [
                  _CardDetalle(
                    tipo: 'RCD',
                    icono: 'assets/icons/rcd.png',
                    color: Color(0xFF1f2858),
                  ),
                  _CardDetalle(
                    tipo: 'Plastico',
                    icono: 'assets/icons/plastico.png',
                    color: Colors.blue,
                  ),
                  _CardDetalle(
                    tipo: 'Metal',
                    icono: 'assets/icons/metal.png',
                    color: Color(0xFF515151),
                  ),
                  _CardDetalle(
                    tipo: 'Papel',
                    icono: 'assets/icons/papel.png',
                    color: Color(0xFF262626),
                  ),
                  _CardDetalle(
                    tipo: 'Madera',
                    icono: 'assets/icons/madera.png',
                    color: Color(0xFF66452e),
                  ),
                  _CardDetalle(
                    tipo: 'Carton',
                    icono: 'assets/icons/carton.png',
                    color: Color(0xFF66452e),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CardDetalle extends StatelessWidget {
  final String tipo;
  final String icono;
  final Color color;

  const _CardDetalle({
    required this.tipo,
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: color,
                radius: 30,
                child: Image.asset(
                  icono,
                  width: 45,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  tipo,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
