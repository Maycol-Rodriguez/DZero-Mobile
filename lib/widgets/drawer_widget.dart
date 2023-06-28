import 'package:dzero/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatefulWidget {
  final User usuario;
  const MyDrawer({
    super.key,
    required this.usuario,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 100,
                backgroundImage: widget.usuario.photoURL != null
                    ? NetworkImage(widget.usuario.photoURL!) as ImageProvider<Object>
                    : const AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(height: 50),
              ListTile(
                onTap: () => context.goNamed(VHomeScreen.name),
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
              ),
              ListTile(
                onTap: () => context.pushNamed(VPerfilScreen.name),
                leading: const Icon(Icons.person),
                title: const Text('Perfil'),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  setState(() {});
                },
                leading: const Icon(Icons.logout_rounded),
                title: const Text('Cerrar sesion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
