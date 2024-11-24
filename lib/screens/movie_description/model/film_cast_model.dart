import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:popcorn/constants/api_constants.dart';

class FilmCastModel {
  List<Cast> cast;
  List<Cast> crew;

  FilmCastModel({
    required this.cast,
    required this.crew,
  });

  factory FilmCastModel.fromJson(Map<String, dynamic> json) => FilmCastModel(
      cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
      crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))));

  static Future<FilmCastModel> fetchFilmCast(int movieID) async {
    final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/$movieID/credits"),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $readaccesstoken'});

    if (response.statusCode == 200) {
      //print('JSON DATA: \n ${response.body}');
      return FilmCastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error getting data');
    }
  }
}

class Cast {
  bool adult;
  int gender;
  int id;
  Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  Department? department;
  String? job;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: departmentValues.map[json["department"]],
        job: json["job"],
      );
}

enum Department {
  ACTING,
  ART,
  CAMERA,
  COSTUME_MAKE_UP,
  CREATOR,
  CREW,
  DIRECTING,
  EDITING,
  LIGHTING,
  PRODUCTION,
  SOUND,
  VISUAL_EFFECTS,
  WRITING
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Creator": Department.CREATOR,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Lighting": Department.LIGHTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
