import 'package:flutter/material.dart';

class MyProfileDrawer extends StatelessWidget {
  const MyProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        children: [
          ListTile(
            splashColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {},
          ),
          Divider(color: Theme.of(context).colorScheme.primary),
          ListTile(
            splashColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.import_export),
            title: const Text('Import Movies'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}