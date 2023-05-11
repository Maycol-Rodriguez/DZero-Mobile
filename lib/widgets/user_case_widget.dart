import 'package:dzero/config/themes/colors_theme.dart';
import 'package:dzero/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class UserCaseWidget extends StatelessWidget {
  const UserCaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _RegisteredCase(
            FontAwesomeIcons.addressBook,
            '10',
            'Tus Casos',
            colorSecondary,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: GestureDetector(
            onTap: () => context.pushNamed(VDemoDataScreen.name),
            child: const _RegisteredCase(
              FontAwesomeIcons.solidMap,
              '23',
              'Ultimos casos',
              colorTerceary,
            ),
          ),
        ),
      ],
    );
  }
}

class _RegisteredCase extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _RegisteredCase(this.icon, this.title, this.subtitle, this.color);

  @override
  Widget build(BuildContext context) {
    return _ContainerDetail(
      icon: icon,
      title: title,
      subtitle: subtitle,
      color: color,
    );
  }
}

class _ContainerDetail extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const _ContainerDetail({
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
            child: FaIcon(icon, color: Colors.white),
          ),
          Positioned(
            bottom: 15,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
