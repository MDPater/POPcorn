import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/film_cast_model.dart';

class FilmCrewView extends StatefulWidget {
  const FilmCrewView({super.key, required this.movieID});
  final int movieID;

  @override
  State<FilmCrewView> createState() => _FilmCrewViewState();
}

class _FilmCrewViewState extends State<FilmCrewView> {
  late Future<FilmCastModel> futureFilmCrew;
  final movieDescriptionController _controller = movieDescriptionController();

  @override
  void initState() {
    super.initState();
    futureFilmCrew = _controller.getFilmCast(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
