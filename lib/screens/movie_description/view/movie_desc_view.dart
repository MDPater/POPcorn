// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/movie_desc_model.dart';
import 'package:popcorn/screens/watched/watched_bottomsheet.dart';
//import 'package:popcorn/widgets/AppBar.dart';
//import 'package:popcorn/widgets/NavDrawer.dart';
//import 'package:popcorn/widgets/ProfileDrawer.dart';

class movieDescriptionView extends StatefulWidget {
  const movieDescriptionView({super.key, required this.movieID});

  final int movieID;

  @override
  State<movieDescriptionView> createState() => _movieDescriptionViewState();
}

class _movieDescriptionViewState extends State<movieDescriptionView> {
  late Future<movieDescriptionModel> futureMovie;
  final movieDescriptionController _controller = movieDescriptionController();

  bool showButton = true;
  String buttonText = "Need to Watch";

  void checkLists() {
    if (boxMovies.get('key_${widget.movieID}') != null) {
      showButton = false;
      buttonText = "Watched the Movie";
    } else if (boxNeedToWatch.get('key_${widget.movieID}') != null) {
      showButton = false;
      buttonText = "Already on Watchlist";
    } else {
      showButton = true;
      buttonText = "Need to Watch";
    }
  }

  void _addmovie() async {
    setState(() {
      showButton = false;
      buttonText = "Added to Watchlist";
    });
  }

  @override
  void initState() {
    super.initState();
    checkLists();
    futureMovie = _controller.getMovieData(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: FutureBuilder<movieDescriptionModel>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  /*
                  Top Bar of the App
                  drawer: const MyNavDrawer(),
                  endDrawer: const MyProfileDrawer(),
                  appBar: const MyAppBar(),
                  */
                  body: ListView(
                    children: [
                      //top picture with back button and movie rating
                      SizedBox(
                        height: 250,
                        child: Stack(
                          children: [
                            //Backdrop Picture
                            Positioned(
                                child: Center(
                              child: Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width - 15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              snapshot.data!.backdrop_path),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            )),
                            //Movie Rating
                            Positioned(
                                bottom: 10,
                                child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Text(
                                          (snapshot.data!.vote_average / 2)
                                              .toStringAsFixed(1),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        )
                                      ],
                                    ))),
                            //Back Button
                            Positioned(
                              child: Container(
                                height: 40,
                                width: 40,
                                margin:
                                    const EdgeInsets.only(left: 20, top: 12),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(8)),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 24,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //Title
                      Container(
                        padding:
                            const EdgeInsets.only(left: 8, top: 8, right: 8),
                        child: Text(
                          snapshot.data!.title,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      //Release Date
                      Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          'release date: ${snapshot.data!.release_date}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Poster, Summary, watchlist button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Poster Box
                          Container(
                            height: 220,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${snapshot.data!.poster_path}'),
                                    fit: BoxFit.cover)),
                          ),
                          //Summary and Button Box
                          SizedBox(
                              height: 220,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                children: [
                                  //Summary
                                  SizedBox(
                                    height: 170,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 142, 132, 151),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, bottom: 1),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text(
                                            snapshot.data!.overview,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //Watchlist Button
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed:
                                            showButton ? _addmovie : null,
                                        style: ElevatedButton.styleFrom(
                                            foregroundColor: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        child: Text(
                                          buttonText,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => WatchedBottomSheet(
                                movieID: widget.movieID,
                                title: snapshot.data!.title,
                                posterurl:
                                    'https://image.tmdb.org/t/p/w500${snapshot.data!.poster_path}',
                                rating:
                                    (snapshot.data!.vote_average).toString()));
                      },
                      label: const Text('Watched'),
                      icon: const Icon(Icons.visibility),
                    ),
                  ),
                );
              } else {
                return const Text('No Data Found');
              }
            }),
      ),
    );
  }
}
