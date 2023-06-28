import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetallesDeUsuariosWidget extends ConsumerWidget {
  const DetallesDeUsuariosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle titleLarge = Theme.of(context).textTheme.titleLarge!;
    final usuario = ref.watch(usuarioAutenticado);

    return GestureDetector(
      onTap: () => context.pushNamed(VPerfilScreen.name),
      child: SizedBox(
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
            Hero(
              tag: 2,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: usuario.photoURL != null
                    ? NetworkImage(usuario.photoURL!) as ImageProvider<Object>
                    : const AssetImage('assets/images/avatar.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
