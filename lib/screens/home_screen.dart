import 'package:flutter/material.dart';
import 'package:popcorn/widget/movie_item.dart';

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
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search Movies',
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text('Top Rated Movies', style: TextStyle(fontSize: 24)),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  movieItem(),
                  movieItem(),
                ],
              ),
            )
          ]),
        ));
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
        const SizedBox(
          height: 40,
          width: 40,
          child: Icon(Icons.person, size: 30),
        )
      ],
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
  );
}
