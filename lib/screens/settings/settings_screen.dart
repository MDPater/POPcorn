import 'package:flutter/material.dart';
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavDrawer.dart';
import 'package:popcorn/widgets/ProfileDrawer.dart';

class settingsView extends StatefulWidget {
  const settingsView({super.key});

  @override
  State<settingsView> createState() => _settingsViewState();
}

class _settingsViewState extends State<settingsView> {
  final myScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: const MyAppBar(),
      drawer: const MyNavDrawer(),
      endDrawer: const MyProfileDrawer(),
      body: Scrollbar(
        controller: myScrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            controller: myScrollController,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
