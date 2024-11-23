import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../constants/api_constants.dart';

class similarMoviesModel {
  List<result> results;

  similarMoviesModel({
    required this.results,
  });

  factory similarMoviesModel.fromJson(Map<String, dynamic> json) {
    return similarMoviesModel(
        results:
            List<result>.from(json['results'].map((x) => result.fromJson(x))));
  }

  static Future<similarMoviesModel> fetchSimilarMovies(int movieID) async {
    final response = await http.get(
        Uri.parse(
            "https://api.themoviedb.org/3/movie/$movieID/recommendations"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      print('JSON DATA: \n ${response.body}');
      return similarMoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error getting data');
    }
  }
}

class result {
  int movieID;
  String title;
  String? poster_path;

  result(
      {required this.movieID, required this.title, required this.poster_path});

  factory result.fromJson(Map<String, dynamic> json) {
    return result(
        movieID: json['id'],
        title: json['title'],
        poster_path: json['poster_path']);
  }
}
