import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:popcorn/constants/api_constants.dart';

class PeopleModel {
  String biography;
  DateTime? birthday;
  int gender;
  int id;
  String? knownForDepartment;
  String name;
  String? profilePath;

  PeopleModel({
    required this.biography,
    required this.birthday,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.profilePath,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      biography: json["biography"],
      birthday: DateTime.parse(json["birthday"]),
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
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
