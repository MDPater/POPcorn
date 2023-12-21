import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:popcorn/model/watchlist/watched_movie.dart';

class watchlist {
  final box = Hive.box('WatchList');
  final List<watched_movie> _movies = [];
  List movieList = [];

  void addMovie(watched_movie movie) {
    _movies.add(movie);

    movieList.add(movie.toMap());
    box.put('movies', movieList);
  }

  void printMovies() {
    for (final movie in _movies) {
      log(movie.toString());
    }
  }
}
