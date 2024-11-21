import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/similar_movie_model.dart';

class movieCast extends StatefulWidget {
  const movieCast({super.key, required this.movieID});

  final int movieID;

  @override
  State<movieCast> createState() => _movieCastState();
}

class _movieCastState extends State<movieCast> {
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
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${widget.movieID}');
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
                          return InkWell(
                            splashColor: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Future.delayed(
                                  const Duration(milliseconds: 300), () {});
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
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].poster_path}'))),
                                  ),
                                  Text(
                                    snapshot.data!.results[index].title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Text(snapshot.data!.results[0].title)
                ],
              );
            } else {
              return const Text('No Data Found');
            }
          }),
    );
  }
}
