// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/model/need_to_watch/needtowatch.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/movie_desc_model.dart';
import 'package:popcorn/screens/movie_description/view/film_cast_view.dart';
import 'package:popcorn/screens/movie_description/view/film_crew_view.dart';
import 'package:popcorn/screens/movie_description/view/similar_movie_view.dart';
import 'package:popcorn/screens/movie_description/view/user_rating_view.dart';
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
  final myScrollController = ScrollController();
  late Future<movieDescriptionModel> futureMovie;
  final movieDescriptionController _controller = movieDescriptionController();

  //movieData
  late AsyncSnapshot snap;

  //Button Logic WatchList
  bool showButton = true;
  String buttonText = "Add to List";

  //Button Logic FAB
  String fabText = "Watched";
  IconData fabIcon = Icons.visibility;

  //bool to show User Review if it exists
  bool userReview = false;

  Future<void> _refreshPage() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      checkMovie();
      futureMovie = _controller.getMovieData(widget.movieID);
    });
  }

  void _addmovieToDB() async {
    //addMovie to the DB
    boxNeedToWatch.put(
        'key_${widget.movieID}',
        needtowatch(
          movieTitle: snap.data!.title,
          posterurl: snap.data!.poster_path,
          star: snap.data!.vote_average,
          movieID: widget.movieID,
        ));
    print(boxNeedToWatch.get('key_${widget.movieID}'));
    setState(() {
      showButton = false;
      buttonText = "Added to Watchlist";
    });
  }

  void checkMovie() {
    //Check DB for Movie Entries and set variables as needed
    if (boxMovies.containsKey('key_${widget.movieID}')) {
      setState(() {
        userReview = true;
        showButton = false;
        buttonText = "Watched the Movie";
        fabText = "Edit";
        fabIcon = Icons.edit;
      });
    } else if (boxNeedToWatch.containsKey('key_${widget.movieID}')) {
      setState(() {
        showButton = false;
        buttonText = "Already on Watchlist";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkMovie();
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
                snap = snapshot;
                bool showBackdrop = true;
                if (snapshot.data!.backdrop_path == null) {
                  showBackdrop = false;
                }
                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  /*
                  Top Bar of the App
                  drawer: const MyNavDrawer(),
                  endDrawer: const MyProfileDrawer(),
                  appBar: const MyAppBar(),
                  */
                  body: RefreshIndicator(
                    onRefresh: _refreshPage,
                    child: Scrollbar(
                      controller: myScrollController,
                      child: ListView(
                        controller: myScrollController,
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
                                    width:
                                        MediaQuery.of(context).size.width - 15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        image: DecorationImage(
                                          image: showBackdrop
                                              ? NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      snapshot
                                                          .data!.backdrop_path
                                                          .toString())
                                              : const AssetImage(
                                                      'assets/images/poster404.jpg')
                                                  as ImageProvider,
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
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 12),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                            padding: const EdgeInsets.only(
                                left: 8, top: 8, right: 8),
                            child: Text(
                              snapshot.data!.title,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          //Release Date
                          Container(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              'release date: ${DateFormat('dd-MM-yyyy').format(snapshot.data!.release_date)}',
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
                                                left: 6, right: 6, bottom: 1),
                                            child: Scrollbar(
                                              controller: myScrollController,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4),
                                                  child: Text(
                                                    snapshot.data!.overview,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //Watchlist Button
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            onPressed: showButton
                                                ? _addmovieToDB
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                            child: Text(
                                              buttonText,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          //Show Cast
                          FilmCastView(movieID: widget.movieID),
                          //Show User Review if it exists in DB
                          userReview
                              ? UserRatingView(
                                  movieID: widget.movieID,
                                  myScrollController: myScrollController,
                                )
                              : Container(
                                  padding: const EdgeInsets.only(top: 8),
                                ),
                          //
                          SimilarMoviesView(movieID: widget.movieID),
                          FilmCrewView(movieID: widget.movieID),
                        ],
                      ),
                    ),
                  ),
                  //floatingActionButtonLocation:FloatingActionButtonLocation.miniEndTop,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        final result = await showModalBottomSheet(
                            context: context,
                            builder: (context) => WatchedBottomSheet(
                                movieID: widget.movieID,
                                title: snapshot.data!.title,
                                posterurl: snapshot.data!.poster_path,
                                rating: snapshot.data!.vote_average));
                        if (result != null) {
                          setState(() {
                            _refreshPage();
                          });
                        }
                      },
                      label: Text(fabText),
                      icon: Icon(fabIcon),
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
