import 'package:flutter/material.dart';

String appbarTitle = "POPcorn";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContainer(context),
      bottomNavigationBar: BottomNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}

AppBar _buildAppBar(context) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.menu,
          color: Colors.black,
          size: 24,
        ),
        Text(appbarTitle),
        Container(
          height: 40,
          width: 40,
          child: const Icon(Icons.person, size: 30),
        )
      ],
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
  );
}

Container _buildContainer(context) {
  return Container(
    child: const Column(children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: SearchBar(
          leading: Icon(Icons.search),
          hintText: 'Search Movies',
          onChanged: (String input) {Movie().f},
        ),
      ),
    ]),
  );
}
