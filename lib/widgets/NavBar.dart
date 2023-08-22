import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.secondary),
              child: Text(
                'POP Menu',
                style: TextStyle(fontSize: 34),
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Watched'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
