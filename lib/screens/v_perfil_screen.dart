import 'package:animate_do/animate_do.dart';
import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VPerfilScreen extends ConsumerWidget {
  static const String name = 'perfil_screen';

  const VPerfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme.titleSmall;
    final usuario = ref.watch(usuarioAutenticado);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Hero(
                    tag: 2,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    usuario.displayName!,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text('Usuario ID: ${usuario.uid.substring(0, 6)}...',
                      textAlign: TextAlign.center, style: textStyle),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Expanded(
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
                    decoration: CustomDecoration.decoration(true, false, true),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      child: Column(
                        children: [
                          FadeInUp(
                            child: _DatosWidget(
                              email: usuario.email!,
                              celular: usuario.phoneNumber,
                              nombre: usuario.displayName,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.edit),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DatosWidget extends StatelessWidget {
  final String email;
  final String? celular;
  final String? nombre;

  const _DatosWidget({
    required this.email,
    required this.nombre,
    required this.celular,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DatosPersonales(dato: email),
        const SizedBox(height: 12),
        _DatosPersonales(dato: celular ?? 'No añadio un telefono'),
        const SizedBox(height: 12),
        _DatosPersonales(dato: nombre ?? 'No añadio un nombre'),
      ],
    );
  }
}

class _DatosPersonales extends StatelessWidget {
  final String dato;
  const _DatosPersonales({
    required this.dato,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/icons/lista.png', width: 20),
        const SizedBox(width: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Expanded(
            child: Text(
              dato,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
