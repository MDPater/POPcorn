import 'package:popcorn/model/boxes.dart';

class movieUserDataModel {
  String comment;
  double starRating;
  DateTime watchedAt;

  movieUserDataModel({
    required this.comment,
    required this.starRating,
    required this.watchedAt,
  });

  factory movieUserDataModel.fromDB(
    dynamic entry,
  ) {
    print('DB DATA: \n$entry');
    return movieUserDataModel(
        comment: entry.comment,
        starRating: entry.starRating,
        watchedAt: entry.movieWatchedAt);
  }

  static Future<movieUserDataModel> fetchMovieEntry(int movieID) async {
    if (boxMovies.containsKey('key_$movieID')) {
      final userData = boxMovies.get('key_$movieID');
      return movieUserDataModel.fromDB(userData);
    } else {
      throw Exception('movieID error');
    }
  }
}
