import 'package:flutter/material.dart';

String appbarTitle = "POPcorn";

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(appbarTitle),
      leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
      actions: <Widget>[Builder(builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),],
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}