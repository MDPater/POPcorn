import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

List<Movie> parseMovie(String responseBody){
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

Future<List<Movie>> fetchMovies(http.Client client) async{
  final response = await client.get(Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=8d28c2f1418b07cac8dfcdbfac0d3a44'));

  return compute(parseMovie, response.body);
}

class Movie {
  final String original_title;
  final int release_date;
  final String poster_path;

  const Movie({
    required this.original_title,
    required this.release_date,
    required this.poster_path,
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      original_title: json['original_title'] as String, 
      release_date: json['release_date'] as int, 
      poster_path: json['poster_path'] as String
    );
  }
}
