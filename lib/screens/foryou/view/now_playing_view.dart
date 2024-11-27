// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:popcorn/screens/foryou/controller/home_screen_controller.dart';
import 'package:popcorn/screens/foryou/model/movie_preview_model.dart';
import 'package:popcorn/screens/movie_description/view/movie_desc_view.dart';

class NowPlayingView extends StatefulWidget {
  const NowPlayingView({super.key});

  @override
  State<NowPlayingView> createState() => _InTheatreState();
}

class _InTheatreState extends State<NowPlayingView> {
  late Future<MoviePreviewModel> futureMovie;
  final HomeScreenController _controller = HomeScreenController();

  @override
  void initState() {
    super.initState();
    futureMovie = _controller.getNowPlaying();
  }

  //Widget that builds Top Rated cards on Home Screen
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('In Theatre Now', style: TextStyle(fontSize: 24)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 260,
            child: FutureBuilder(
                future: futureMovie,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.results.length,
                        itemBuilder: (context, index) {
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
                                                movieID: snapshot
                                                    .data!.results[index].id)));
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
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    snapshot
                                                        .data!
                                                        .results[index]
                                                        .posterPath))),
                                  ),
                                  Container(
                                    child: Text(
                                      snapshot.data!.results[index].title,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Text('No Data Found');
                  }
                }),
          )
        ],
      ),
    );
  }
}
