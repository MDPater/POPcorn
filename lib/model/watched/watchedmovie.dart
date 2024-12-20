import 'package:hive/hive.dart';

part 'watchedmovie.g.dart';

@HiveType(typeId: 1)
class watchedmovie {
  watchedmovie(
      {required this.movieTitle,
      required this.posterurl,
      required this.starRating,
      required this.movieID,
      required this.comment,
      required this.movieWatchedAt});

  @HiveField(0)
  String movieTitle;

  @HiveField(1)
  String posterurl;

  @HiveField(2)
  String comment;

  @HiveField(3)
  double starRating;

  @HiveField(4)
  int movieID;

  @HiveField(5)
  DateTime movieWatchedAt;

  Map<String, dynamic> toMap() {
    return {
      'movieTitle': movieTitle,
      'posterurl': posterurl,
      'starRating': starRating,
      'movieID': movieID,
      'comment': comment,
      'movieWatchedAt': movieWatchedAt
    };
  }

  factory watchedmovie.fromMap(Map map) {
    return watchedmovie(
        movieTitle: map['movieTitle'],
        posterurl: map['posterurl'],
        starRating: map['starRating'],
        movieID: map['movieID'],
        comment: map['comment'],
        movieWatchedAt: map['movieWatchedAt']);
  }

  @override
  String toString() {
    return 'movieTitle: $movieTitle posterurl: $posterurl starRating: $starRating movieID: $movieID comment: $comment movieWatchedAt: $movieWatchedAt';
  }
}
