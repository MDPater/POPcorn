import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:popcorn/constants/api_constants.dart';

class PeopleModel {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  dynamic birthday;
  dynamic deathday;
  int gender;
  dynamic homepage;
  int id;
  dynamic imdbId;
  String knownForDepartment;
  String name;
  dynamic placeOfBirth;
  double popularity;
  dynamic profilePath;

  PeopleModel({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      adult: json["adult"],
      alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
      biography: json["biography"],
      birthday: json["birthday"],
      deathday: json["deathday"],
      gender: json["gender"],
      homepage: json["homepage"],
      id: json["id"],
      imdbId: json["imdb_id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      placeOfBirth: json["place_of_birth"],
      popularity: json["popularity"]?.toDouble(),
      profilePath: json["profile_path"],
    );
  }

  static Future<PeopleModel> fetchPeopleData(int id) async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/person/$id?language=en-US'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});
    if (response.statusCode == 200) {
      print('JSON DATA: ${response.body}');
      return PeopleModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
