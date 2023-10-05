import 'package:flutter/material.dart';

//import App navigation modules
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavBar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavBar(),
      appBar: const MyAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("This is a Max de Pater creation", style: TextStyle(fontSize: 24),),
          ),
        ],
      ),
    );
  }
}