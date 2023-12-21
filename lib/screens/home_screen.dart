//import flutter basic classes
import 'package:flutter/material.dart';
import 'package:popcorn/data/tmdb_api_calls.dart';

//import App navigation modules
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavBar.dart';

//import Movie Widgets
import 'package:popcorn/widgets/movie-widgets/inTheatre.dart';
import 'package:popcorn/widgets/movie-widgets/toprated.dart';
import 'package:popcorn/widgets/movie-widgets/trending.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TMDBAPI tmdb = TMDBAPI();

  @override
  //initializing on Start
  void initState() {
    // functions to call
    tmdb.loadmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Main Scaffold that holds Layout and links to widgets
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavBar(),
      appBar: const MyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            SearchBar(
              leading: const Icon(Icons.search),
              hintText: 'Search Movies',
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 30,
            ),
            TrendingMovies(Trending: tmdb.trendingMovies),
            InTheatre(Theatre: tmdb.theatreMovies),
            TopRatedMovies(TopRated: tmdb.topratedMovies),
          ]),
        ),
      ),
    );
  }
}
