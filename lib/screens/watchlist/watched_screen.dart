import 'package:flutter/material.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/model/watchlist/watchedmovie.dart';

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
          child: GridView.builder(
              itemCount: boxMovies.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                watchedmovie movie = boxMovies.getAt(index);
                return ListTile(
                  leading: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.remove)),
                  title: Text(movie.movieTitle.toLowerCase()),
                );
              })),
    );
  }
}
