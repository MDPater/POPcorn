import 'package:flutter/material.dart';
import 'package:popcorn/widgets/toprated.dart';
import 'package:popcorn/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:popcorn/constants/api_constants.dart';

String appbarTitle = "POPcorn";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List topratedMovies = [];
  List trendingMovies = [];

  @override
  //initializing on Start
  void initState() {
    // functions to call
    loadmovies();
    super.initState();
  }

  //load Top rated Movies from TMDB
  loadmovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(API_Key, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map topratedresult = await tmdbLogs.v3.movies.getTopRated();
    Map trendingresult = await tmdbLogs.v3.movies.getPopular();

    setState(() {
      topratedMovies = topratedresult['results'];
      trendingMovies = trendingresult['results'];
    });

    //show output of API call
    print(topratedMovies);
  }

  @override
  Widget build(BuildContext context) {
    //Main Scaffold that holds Layout and links to widgets
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            const SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search Movies',
            ),
            const SizedBox(
              height: 30,
            ),
            TrendingMovies(Trending: trendingMovies),
            TopRatedMovies(TopRated: topratedMovies),
          ]),
        ));
  }
}

//Topbar of the App
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
