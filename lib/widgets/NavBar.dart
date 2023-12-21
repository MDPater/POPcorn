import 'package:flutter/material.dart';
import 'package:popcorn/screens/about_screen.dart';
import 'package:popcorn/screens/home_screen.dart';
import 'package:popcorn/screens/watchlist/watched_screen.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

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
            child:
                const Image(image: AssetImage("assets/Logo/POPcorn_logo.png")),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const HomeScreen())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text('Watched'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const WatchedScreen())));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AboutScreen())));
            },
          ),
        ],
      ),
    );
  }
}
