import 'package:dzero/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetallesDeUsuariosWidget extends StatelessWidget {
  const DetallesDeUsuariosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleLarge = Theme.of(context).textTheme.titleLarge!;
    return GestureDetector(
      onTap: () => context.pushNamed(VPerfilScreen.name),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Miguel\nPerez',
              style: titleLarge,
            ),
            const Hero(
              tag: 2,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
