import 'package:flutter/material.dart';

class VLoginScreen extends StatelessWidget {
  static const String name = 'login_screen';

  const VLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('LoginScreen'),
      ),
    );
  }
}