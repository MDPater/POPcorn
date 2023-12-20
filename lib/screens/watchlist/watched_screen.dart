import 'package:flutter/material.dart';

//import App navigation modules
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavBar.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({super.key});

  @override
  State<WatchedScreen> createState() => _Watched_ScreenState();
}

class _Watched_ScreenState extends State<WatchedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavBar(),
      appBar: const MyAppBar(),
      body: Container(
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 24, left: 24),
              child: Text("Your watched Movies", style: TextStyle(fontSize: 24),),
            ),
          ],
        ),
      ),
    );
  }
}