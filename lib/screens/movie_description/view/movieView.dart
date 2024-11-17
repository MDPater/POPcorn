import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/movie_desc_model.dart';
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavDrawer.dart';
import 'package:popcorn/widgets/ProfileDrawer.dart';

class movieDescriptionView extends StatefulWidget {
  const movieDescriptionView({super.key, required this.movieID});

  final int movieID;

  @override
  State<movieDescriptionView> createState() => _movieDescriptionViewState();
}

class _movieDescriptionViewState extends State<movieDescriptionView> {
  late Future<movieDescriptionModel> futureMovie;
  final movieDescriptionController _controller = movieDescriptionController();

  @override
  void initState() {
    super.initState();
    futureMovie = _controller.getMovieData(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavDrawer(),
      endDrawer: const MyProfileDrawer(),
      appBar: const MyAppBar(),
      body: Center(
        child: FutureBuilder<movieDescriptionModel>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    Text('title: ${snapshot.data!.title}'),
                    Text('summary: ${snapshot.data!.overview}')
                  ],
                );
              } else {
                return const Text('No Data Found');
              }
            }),
      ),
    );
  }
}
