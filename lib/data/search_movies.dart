import 'package:flutter/material.dart';

class Movie {
  final String title;
  final int year;
  final Image cover;

  const Movie({
    required this.title,
    required this.year,
    required this.cover,
  });
}
