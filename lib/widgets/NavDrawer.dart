import 'package:flutter/material.dart';
import 'package:popcorn/screens/settings/about_screen.dart';
import 'package:popcorn/screens/foryou/view/home_screen_view.dart';
import 'package:popcorn/screens/settings/settings_screen.dart';
import 'package:popcorn/screens/watchlist/watchlist_screen.dart';
import 'package:popcorn/screens/watched/view/watched_list_view.dart';

class MyNavDrawer extends StatelessWidget {
  const MyNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            child:
                const Image(image: AssetImage("assets/Logo/POPcorn_logo.png")),
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Future.delayed(const Duration(milliseconds: 150), () {
                // Do something
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const HomeScreen())));
              });
            },
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.library_books_rounded),
            title: const Text('Watchlist'),
            onTap: () {
              //navigate to need to watch page
              Future.delayed(const Duration(milliseconds: 150), () {
                // Do something
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const watchlist())));
              });
            },
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.visibility),
            title: const Text('Watched'),
            onTap: () {
              Future.delayed(const Duration(milliseconds: 150), () {
                // Do something
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const WatchedScreen())));
              });
            },
          ),
          const Divider(),
          ListTile(
            splashColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Future.delayed(const Duration(milliseconds: 150), () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const settingsView())));
              });
            },
          ),
          const Divider(),
          ListTile(
            splashColor: Theme.of(context).colorScheme.secondary,
            leading: const Icon(Icons.contact_page),
            title: const Text('About'),
            onTap: () {
              Future.delayed(const Duration(milliseconds: 150), () {
                // Do something
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AboutScreen())));
              });
            },
          ),
        ],
      ),
    );
  }
}
