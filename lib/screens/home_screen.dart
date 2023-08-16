import 'package:flutter/material.dart';
import 'package:popcorn/widgets/toprated.dart';
import 'package:popcorn/data/tmdb_api.dart';

String appbarTitle = "POPcorn";
final tmdb db = tmdb();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  //initializing on Start
  void initState() {
    // functions to call
    db.loadmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Main Scaffold that holds Layout and links to widgets
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search Movies',
            ),
            const SizedBox(
              height: 30,
            ),
            TopRatedMovies(TopRated: tmdb.TopratedMovies)
            /*SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [TopRatedMovies(TopRated: TopRated)],
              ),
            )*/
          ]),
        ));
  }
}

//Topbar
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

//Add update function to refresh list of tmdb Movies
