import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/similar_movie_model.dart';
import 'package:popcorn/screens/movie_description/view/movie_desc_view.dart';

class SimilarMoviesView extends StatefulWidget {
  const SimilarMoviesView({super.key, required this.movieID});

  final int movieID;

  @override
  State<SimilarMoviesView> createState() => _SimilarMoviesView();
}

class _SimilarMoviesView extends State<SimilarMoviesView> {
  late Future<similarMoviesModel> futureSimilarMovies;
  final movieDescriptionController _controller = movieDescriptionController();

  @override
  void initState() {
    super.initState();
    futureSimilarMovies = _controller.getSimilarMovies(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder(
          future: futureSimilarMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Similar Movies',
                        style: TextStyle(fontSize: 20),
                      )),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.results.length,
                        itemBuilder: (context, index) {
                          bool showImage = true;
                          if (snapshot.data!.results[index].poster_path ==
                              null) {
                            showImage = false;
                          }
                          return InkWell(
                            splashColor: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            movieDescriptionView(
                                                movieID: snapshot.data!
                                                    .results[index].movieID)));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                    height: 195,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: showImage
                                                ? NetworkImage(
                                                    'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].poster_path}')
                                                : const AssetImage(
                                                        'assets/images/poster404.jpg')
                                                    as ImageProvider)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.results[index].title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return const Text('No Data Found');
            }
          }),
    );
  }
}
