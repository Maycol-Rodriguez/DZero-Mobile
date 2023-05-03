import 'package:dzero/config/themes/colors_theme.dart';
import 'package:flutter/material.dart';

class VPerfilScreen extends StatelessWidget {
  static const String name = 'perfil_screen';

  const VPerfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                children: const [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Maycol Rodriguez',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Agente ID: RS-123456',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 40),
                      child: Column(
                        children: const [
                          _DatosWidget(
                            email: 'Maycol354@gmail.com',
                            celular: '998238145',
                            direccion: 'Calle Santa Lucia 223',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorTerceary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(30, 55),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(Icons.edit, size: 25),
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
  final String? direccion;
  const _DatosWidget({
    Key? key,
    required this.email,
    this.celular,
    this.direccion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/icons/lista.png', width: 20),
            const SizedBox(width: 15),
            Text(
              email,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (celular != null)
          Row(
            children: [
              Image.asset('assets/icons/lista.png', width: 20),
              const SizedBox(width: 15),
              Text(
                celular!,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        const SizedBox(height: 12),
        if (direccion != null)
          Row(
            children: [
              Image.asset('assets/icons/lista.png', width: 20),
              const SizedBox(width: 15),
              Text(
                direccion!,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
              ),
            ],
          ),
      ],
    );
  }
}
