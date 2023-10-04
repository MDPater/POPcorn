import 'dart:math';

import 'package:flutter/material.dart';
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/movie-widgets/inTheatre.dart';
import 'package:popcorn/widgets/movie-widgets/toprated.dart';
import 'package:popcorn/widgets/movie-widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:popcorn/constants/api_constants.dart';
import 'package:popcorn/widgets/NavBar.dart';

String appbarTitle = "POPcorn";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();
  final TextEditingController searchController = TextEditingController();

  List theatreMovies = [];
  List topratedMovies = [];
  List trendingMovies = [];

  @override
  //initializing on Start
  void initState() {
    // functions to call
    loadmovies();
    super.initState();
  }

  //load Movie Lists from TMDB
  loadmovies() async {
    int randomtoprated = random.nextInt(10) + 1;
    TMDB tmdbLogs = TMDB(ApiKeys(API_Key, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map topratedresult =
        await tmdbLogs.v3.movies.getTopRated(page: randomtoprated);
    Map trendingresult = await tmdbLogs.v3.movies.getPopular();
    Map intheatre = await tmdbLogs.v3.movies.getNowPlaying();

    setState(() {
      topratedMovies = topratedresult['results'];
      trendingMovies = trendingresult['results'];
      theatreMovies = intheatre['results'];
    });

    //show output of API call
    print(topratedresult);
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
              controller: searchController,
              leading: const Icon(Icons.search),
              hintText: 'Search Movies',
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 30,
            ),
            TrendingMovies(Trending: trendingMovies),
            InTheatre(Theatre: theatreMovies),
            TopRatedMovies(TopRated: topratedMovies),
          ]),
        ),
      ),
    );
  }

  //Topbar of the App
  AppBar _buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          Text(appbarTitle),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                size: 30,
              )),
        ],
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
