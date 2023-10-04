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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(builder: (context) {
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
          Text(appbarTitle),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                size: 30,
              )),
        ],
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}