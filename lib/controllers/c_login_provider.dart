import 'dart:convert';

import 'package:dzero/config/constants/environment.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final String _baseUrl = Environment.firebaseAuthBaseUrl;
  final String _firebaseToken = Environment.firebaseAuthApiKey;

  Future<String?> crearUsuario(
    String fullName,
    String email,
    String password,
    String rePassword,
  ) async {
    String? passwordValidado = "";

    if (password == rePassword) {
      passwordValidado = password;
    }

    final Map<String, dynamic> autenticacionDatos = {
      'email': email,
      'password': passwordValidado,
      'fullName': fullName,
    };

    final url = Uri.http(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final respuesta =
        await http.post(url, body: json.encode(autenticacionDatos));
    final Map<String, dynamic> decodedRespuesta = json.decode(respuesta.body);

    if (decodedRespuesta.containsKey('idToken')) {
      return null;
    } else {
      return decodedRespuesta['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> autenticacionDatos = {
      'email': email,
      'password': password,
    };

    final url = Uri.http(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final respuesta =
        await http.post(url, body: json.encode(autenticacionDatos));
    final Map<String, dynamic> decodedRespuesta = json.decode(respuesta.body);

    if (decodedRespuesta.containsKey('idToken')) {
      // Token hay que guardarlo en el storage
      return null;
    } else {
      return decodedRespuesta['error']['message'];
    }
  }
}
