import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:popcorn/constants/api_constants.dart';

class WatchedBottomsheetModel {
  String title;
  String? posterUrl;
  int id;
  double rating;
  DateTime? releaseDate;

  WatchedBottomsheetModel(
      {required this.id,
      required this.posterUrl,
      required this.rating,
      required this.releaseDate,
      required this.title});

  factory WatchedBottomsheetModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return WatchedBottomsheetModel(
        id: json['id'],
        posterUrl: json['poster_path'],
        rating: json['vote_average'],
        releaseDate: DateTime.tryParse(json['release_date']),
        title: json['title']);
  }

  static Future<WatchedBottomsheetModel> fetchMovieData(int id) async {
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/$id?language=en-US"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      return WatchedBottomsheetModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
