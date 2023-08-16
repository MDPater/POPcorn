import 'package:tmdb_api/tmdb_api.dart';

class tmdb {
  static List TopratedMovies = [];
  final String apikey = "8d28c2f1418b07cac8dfcdbfac0d3a44";
  final String readaccesstoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZDI4YzJmMTQxOGIwN2NhYzhkZmNkYmZhYzBkM2E0NCIsInN1YiI6IjYzZGFjNjA1YTZjMTA0MDA4NTg3Y2YzNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fVZtxE0HhKVu6Q9mIztpQoOtwosTr2qKp1eKAGrz8u8";

  loadmovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map topratedresult = await tmdbLogs.v3.movies.getTopRated();

    TopratedMovies = topratedresult['results'];

    //show output of API call
    print(TopratedMovies);
  }
}
