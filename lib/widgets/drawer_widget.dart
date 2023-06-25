import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const DrawerWidget(this.drawerKey, {Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int navDrawerIndex = 0;
  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        navDrawerIndex = value;
        setState(() {});

        final menuItem = appMenuItem[value];
        context.push(menuItem.link);
        widget.drawerKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 35, 16, 10),
        ),
        ...appMenuItem.sublist(0, 1).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon, color: Colors.black),
                label: Text(item.title),
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 16),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text(
            'Configuración',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ...appMenuItem.sublist(1, 2).map(
              (item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                label: Text(item.title),
              ),
            ),
      ],
    );
  }
}
