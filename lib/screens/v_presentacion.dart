import 'package:animate_do/animate_do.dart';
import 'package:dzero/config/themes/colors_theme.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VPresentacionScreen extends ConsumerStatefulWidget {
  static const String name = 'presentacion_screen';

  const VPresentacionScreen({Key? key}) : super(key: key);

  @override
  VPresentacionScreenState createState() => VPresentacionScreenState();
}

class VPresentacionScreenState extends ConsumerState<VPresentacionScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  bool _last = false;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: tutorial.length,
      vsync: this,
      initialIndex: _index,
    );
    controller.addListener(() {
      setState(() {
        _index = controller.index;
      });
      if (controller.index == tutorial.length - 1) {
        _last = true;
      } else {
        _last = false;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadeInRight(
        child: Stack(
          children: [
            TabBarView(
              controller: controller,
              children: tutorial,
            ),
            (_last)
                ? Positioned(
                    bottom: 40,
                    right: 20,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        context.goNamed(VHomeScreen.name);
                      },
                      label: const Text('Comenzar'),
                    ),
                  )
                : Positioned(
                    bottom: 40,
                    width: size.width,
                    child: Center(
                      child: TabPageSelector(
                        controller: controller,
                        color: Colors.white.withOpacity(0.4),
                        borderStyle: BorderStyle.none,
                        selectedColor: colorTerceary,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
