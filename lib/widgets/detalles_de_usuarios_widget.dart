import 'package:dzero/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetallesDeUsuariosWidget extends ConsumerStatefulWidget {
  const DetallesDeUsuariosWidget({Key? key}) : super(key: key);

  @override
  DetallesDeUsuariosWidgetState createState() => DetallesDeUsuariosWidgetState();
}

class DetallesDeUsuariosWidgetState extends ConsumerState<DetallesDeUsuariosWidget> {
  @override
  Widget build(BuildContext context) {
    final TextStyle titleLarge = Theme.of(context).textTheme.titleLarge!;
    final usuario = ref.watch(usuarioAutenticado);

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            usuario.displayName!.contains(' ')
                ? usuario.displayName!.split(' ').join('\n')
                : usuario.displayName!,
            style: titleLarge,
          ),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(150)),
              child: usuario.photoURL != null
                  ? FadeInImage(
                      placeholder: const AssetImage('assets/loaders/jar-loading.gif'),
                      image: Image.network(
                        usuario.photoURL!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ).image,
                    )
                  : const Image(
                      image: AssetImage('assets/images/avatar.png'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
