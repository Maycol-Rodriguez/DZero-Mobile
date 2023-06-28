import 'package:dzero/config/mappers/auth_user.dart';
import 'package:dzero/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Autenticacion {
  UserCredential? usuarioAutenticado;

  static Future<UserCredential?> crearCuenta(AuthUser user) async {
    try {
      final credencial = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return credencial;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        mostrarSnackBar(user.context, 'La contraseña es muy debil.');
      }
      if (e.code == 'email-already-in-use') {
        mostrarSnackBar(user.context, 'El correo ya se encuentra en uso.');
      }
      if (e.code == 'operation-not-allowed') {
        mostrarSnackBar(user.context, 'Operacion no permitida.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<UserCredential?> iniciarSesion(AuthUser user) async {
    try {
      final credencial = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      usuarioAutenticado = credencial;

      return credencial;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        mostrarSnackBar(user.context, 'No se encontro una cuenta con ese correo.');
      }
      if (e.code == 'wrong-password') {
        mostrarSnackBar(user.context, 'Contraseña incorrecta.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
