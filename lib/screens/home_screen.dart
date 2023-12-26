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
  final SearchController controller = SearchController();
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
                viewHintText: 'Search...',
                viewLeading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      controller.closeView(controller.text);
                      searchMovies.clear();
                      FocusScope.of(context).unfocus();
                    });
                  },
                ),
                viewTrailing: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _getMovies(controller.text);
                        });
                      },
                      icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        controller.clear();
                        searchMovies.clear();
                      },
                      icon: const Icon(Icons.clear))
                ],
                searchController: controller,
                isFullScreen: false,
                builder: (context, controller) {
                  return SearchBar(
                    controller: controller,
                    leading: const Icon(Icons.search),
                    hintText: 'Search Movies',
                    onTap: () {
                      controller.openView();
                      controller.addListener(() {
                        setState(() {
                          _getMovies(controller.text);
                          if (controller.text == '') {
                            searchMovies.clear();
                          }
                        });
                      });
                    },
                  );
                },
                suggestionsBuilder: (context, controller) {
                  return List<ListTile>.generate(searchMovies.length, (index) {
                    final String item = searchMovies[index]['original_title'];
                    final String year = searchMovies[index]['release_date'];
                    return ListTile(
                      title: Text(item),
                      subtitle: Text(year),
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        setState(() {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            controller.closeView(item);
                            FocusScope.of(context).unfocus();
                          });
                        });
                      },
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
