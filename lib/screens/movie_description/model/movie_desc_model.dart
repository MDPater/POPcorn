import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:popcorn/constants/api_constants.dart';

class movieDescriptionModel {
  //Movie Data
  int movieID;
  String original_title;
  String overview;
  String backdrop_path;
  String poster_path;
  DateTime release_date;
  double vote_average;
  String title;
  String tagline;
  String status;

  movieDescriptionModel({
    required this.movieID,
    required this.original_title,
    required this.overview,
    required this.backdrop_path,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
    required this.title,
    required this.tagline,
    required this.status,
  });

  factory movieDescriptionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return movieDescriptionModel(
      movieID: json['id'],
      original_title: json['original_title'],
      overview: json['overview'],
      backdrop_path: json['backdrop_path'],
      poster_path: json['poster_path'],
      release_date: DateTime.parse(json['release_date']),
      vote_average: json['vote_average'],
      title: json['title'],
      tagline: json['tagline'],
      status: json['status'],
    );
  }

  static Future<movieDescriptionModel> fetchMovieData(int movieID) async {
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/$movieID?language=en-US"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      print(response.body);
      return movieDescriptionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Movie Data');
    }
  }
}
