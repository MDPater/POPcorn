import 'package:hive/hive.dart';

part 'needtowatch.g.dart';

@HiveType(typeId: 2)
class needtowatch {
  needtowatch(
      {required this.movieTitle,
      required this.movieID,
      required this.star,
      required this.posterurl});

  @HiveField(0)
  String movieTitle;

  @HiveField(1)
  String posterurl;

  @HiveField(2)
  dynamic star;

  @HiveField(3)
  int movieID;

  Map<String, dynamic> toMap() {
    return {
      'movieTitle': movieTitle,
      'posterurl': posterurl,
      'starRating': star,
      'movieID': movieID,
    };
  }

  factory needtowatch.fromMap(Map map) {
    return needtowatch(
      movieTitle: map['movieTitle'],
      posterurl: map['posterurl'],
      star: map['starRating'],
      movieID: map['movieID'],
    );
  }
  @override
  String toString() {
    return 'movieTitle: $movieTitle posterurl: $posterurl starRating: $star movieID: $movieID';
  }
}
