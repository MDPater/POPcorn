import 'dart:math';

import 'package:tmdb_api/tmdb_api.dart';

import '../constants/api_constants.dart';

class TMDBAPI {
  Random random = Random();

  List theatreMovies = [];
  List topratedMovies = [];
  List trendingMovies = [];

  loadmovies() async {
    int randomtoprated = random.nextInt(10) + 1;
    TMDB tmdbLogs = TMDB(ApiKeys(API_Key, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map topratedresult =
        await tmdbLogs.v3.movies.getTopRated(page: randomtoprated);
    Map trendingresult = await tmdbLogs.v3.movies.getPopular();
    Map intheatre = await tmdbLogs.v3.movies.getNowPlaying();

    topratedMovies = topratedresult['results'];
    trendingMovies = trendingresult['results'];
    theatreMovies = intheatre['results'];

    //show output of API call
    print(topratedresult);
  }
}
