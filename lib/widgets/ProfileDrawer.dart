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
            leading: const Icon(Icons.import_export),
            title: const Text('Import Data'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}