import 'package:dzero/config/config.dart';
import 'package:dzero/controllers/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final iniciarSesion = FutureProvider.family<UserCredential?, AuthUser>((ref, usuario) async {
  return await Autenticacion.iniciarSesion(usuario);
});
