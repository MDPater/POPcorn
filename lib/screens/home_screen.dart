import 'package:flutter/material.dart';
import 'package:popcorn/widgets/toprated.dart';
import 'package:tmdb_api/tmdb_api.dart';

String appbarTitle = "POPcorn";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List TopratedMovies = [];
  final String apikey = "8d28c2f1418b07cac8dfcdbfac0d3a44";
  final String readaccesstoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZDI4YzJmMTQxOGIwN2NhYzhkZmNkYmZhYzBkM2E0NCIsInN1YiI6IjYzZGFjNjA1YTZjMTA0MDA4NTg3Y2YzNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fVZtxE0HhKVu6Q9mIztpQoOtwosTr2qKp1eKAGrz8u8";

  @override
  //initializing on Start
  void initState() {
    // functions to call
    loadmovies();
    super.initState();
  }

  //load Top rated Movies from TMDB
  loadmovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map topratedresult = await tmdbLogs.v3.movies.getTopRated();

    setState(() {
      TopratedMovies = topratedresult['results'];
    });

    //show output of API call
    print(TopratedMovies);
  }

  @override
  Widget build(BuildContext context) {
    //Main Scaffold that holds Layout and links to widgets
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
            TopRatedMovies(TopRated: TopratedMovies)
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
