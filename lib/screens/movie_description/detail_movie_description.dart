import 'package:flutter/material.dart';
import 'package:popcorn/screens/watched/watched_bottomsheet.dart';
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavDrawer.dart';
import 'package:popcorn/widgets/ProfileDrawer.dart';

import 'package:tmdb_api/tmdb_api.dart';
import 'package:popcorn/constants/api_constants.dart';

class DetailMovieDescription extends StatefulWidget {
  const DetailMovieDescription({super.key, required this.movieID});

  final int movieID;

  @override
  State<DetailMovieDescription> createState() => _DetailMovieDescriptionState();
}

class _DetailMovieDescriptionState extends State<DetailMovieDescription> {
  List movie = [];
  List castMovie = [];
  List similarMovies = [];

  @override
  void initState() {
    getMovie();
    super.initState();
  }

  getMovie() async {
    TMDB tmdbLogs = TMDB(ApiKeys(API_Key, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map movieData = await tmdbLogs.v3.movies.getDetails(widget.movieID);
    Map movieCast = await tmdbLogs.v3.movies.getCredits(widget.movieID);
    Map movieSimilar = await tmdbLogs.v3.movies.getSimilar(widget.movieID);

    setState(() {
      movie = movieData[''];
      castMovie = movieCast['cast'];
      similarMovies = movieSimilar['results'];
    });
    print(movie);
    print(movieCast);
    print(movieSimilar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavDrawer(),
      endDrawer: const MyProfileDrawer(),
      appBar: const MyAppBar(),
      body: ListView(
        children: const [],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => WatchedBottomSheet(
                    movieID: widget.movieID,
                    title: "test",
                    posterurl: widget.movieID.toString(),
                    rating: widget.movieID.toString()));
          },
          label: const Text('Watched'),
          icon: const Icon(Icons.visibility),
        ),
      ),
    );
  }
}
