//import flutter basic classes
import 'package:flutter/material.dart';
import 'dart:math';

//import App navigation modules
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavBar.dart';

//import Movie Widgets
import 'package:popcorn/widgets/movie-widgets/inTheatre.dart';
import 'package:popcorn/widgets/movie-widgets/toprated.dart';
import 'package:popcorn/widgets/movie-widgets/trending.dart';

//import TMDB
import 'package:tmdb_api/tmdb_api.dart';
import '../constants/api_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();

  List theatreMovies = [];
  List topratedMovies = [];
  List trendingMovies = [];

  List searchMovies = [];

  @override
  //initializing on Start
  void initState() {
    // functions to call
    loadmovies();
    super.initState();
  }

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

  _getMovies(String searchValue) async {
    TMDB tmdbLogs = TMDB(ApiKeys(API_Key, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map searchResult = await tmdbLogs.v3.search.queryMovies(searchValue);

    setState(() {
      searchMovies = searchResult['results'];
    });

    print(searchResult);
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: searchMovies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchMovies[index]['original_title']),
          );
        });
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
            SearchAnchor(
                isFullScreen: false,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    leading: const Icon(Icons.search),
                    hintText: 'Search Movies',
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (value) {
                      controller.openView();
                    },
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(searchMovies.length, (index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                    );
                  });
                }),
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
}
