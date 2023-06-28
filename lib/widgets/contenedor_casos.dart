import 'package:dzero/config/config.dart';
import 'package:dzero/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CasosDeUsuariosWidget extends StatelessWidget {
  final int misCasos;
  final int ultimosCasos;

  const CasosDeUsuariosWidget(
    this.misCasos,
    this.ultimosCasos, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              _CasosRegistrados(
                FontAwesomeIcons.addressBook,
                '$misCasos',
                'Tus Casos',
                colorSecondary,
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.pushNamed(MisCasosScreen.name),
                    overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: CustomBorder.radiusAll,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Stack(
            children: [
              _CasosRegistrados(
                FontAwesomeIcons.solidMap,
                '$ultimosCasos',
                'Ultimos casos',
                colorTerceary,
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.pushNamed(CasosReportadosScreen.name),
                    overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: CustomBorder.radiusAll,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CasosRegistrados extends StatelessWidget {
  final IconData icon;
  final String nroDeCasos;
  final String titulo;
  final Color color;

  const _CasosRegistrados(this.icon, this.nroDeCasos, this.titulo, this.color);

  @override
  Widget build(BuildContext context) {
    return _InformacionDelCaso(
      icon: icon,
      title: nroDeCasos,
      subtitle: titulo,
      color: color,
    );
  }
}

class _InformacionDelCaso extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const _InformacionDelCaso({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.4,
      height: size.width * 0.55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            right: 15,
            child: FaIcon(icon),
          ),
          Positioned(
            bottom: 15,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                Text(subtitle, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
