import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:popcorn/constants/api_constants.dart';

class PeopleCreditModel {
  List<Cast> cast;
  List<Cast> crew;
  int id;

  PeopleCreditModel({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory PeopleCreditModel.fromJson(Map<String, dynamic> json) =>
      PeopleCreditModel(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
        id: json["id"],
      );

  static Future<PeopleCreditModel> fetchPeopleCredit(int id) async {
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/person/$id/movie_credits"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      //print('JSON DATA: \n${response.body}');
      return PeopleCreditModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Credits');
    }
  }
}

class Cast {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  Cast({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );
}
