import 'package:flutter/material.dart';

class AuthUser {
  final String email;
  final String password;
  final BuildContext context;

  AuthUser(this.context, {required this.email, required this.password});
}
