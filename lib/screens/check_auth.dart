import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  static const String name = 'loader_screen';
  const LoaderScreen({Key? key}) : super(key: key);

  get builder => null;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          // child: FutureBuilder(
          //   future: FirebaseAuth.instance.currentUser!.getIdToken(),
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     if (!snapshot.hasData) {}
          //     if (snapshot.data == null) {
          //       context.pushReplacement('/login');
          //     } else {
          //       context.pushReplacement('/home');
          //     }
          //     return Container();
          //   },
          // ),
          ),
    );
  }
}
