import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:popcorn/constants/api_constants.dart';

class MoviePreviewModel {
  int page;
  List<Result> results;

  MoviePreviewModel({
    required this.page,
    required this.results,
  });

  factory MoviePreviewModel.fromJson(Map<String, dynamic> json) =>
      MoviePreviewModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  static Future<MoviePreviewModel> fetchNowPlaying() async {
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/now_playing"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      return MoviePreviewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  static Future<MoviePreviewModel> fetchPopular() async {
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/popular"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      return MoviePreviewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  static Future<MoviePreviewModel> fetchTopRated() async {
    Random random = Random();
    int page = random.nextInt(10) + 1;
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/top_rated?page=$page"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      return MoviePreviewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}

class Result {
  int id;
  String backdropPath;
  String originalTitle;
  String posterPath;
  String title;

  Result({
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.posterPath,
    required this.title,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        title: json["title"],
      );
}
