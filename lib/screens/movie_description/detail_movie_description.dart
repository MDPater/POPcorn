import 'package:flutter/material.dart';
import 'package:popcorn/model/need_to_watch/needtowatch.dart';
import 'package:popcorn/screens/watched/watched_bottomsheet.dart';
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavDrawer.dart';
import 'package:popcorn/widgets/ProfileDrawer.dart';
import 'package:popcorn/model/boxes.dart';

import 'package:tmdb_api/tmdb_api.dart';
import 'package:popcorn/constants/api_constants.dart';

class DetailMovieDescription extends StatefulWidget {
  const DetailMovieDescription({super.key, required this.movieID});

  final int movieID;

  @override
  State<DetailMovieDescription> createState() => _DetailMovieDescriptionState();
}

class _DetailMovieDescriptionState extends State<DetailMovieDescription> {
  //Movie Data
  List movie = [];
  List castMovie = [];
  List similarMovies = [];

  //Button
  bool showButton = true;
  String buttonText = "Need to Watch";

  void checkWatchedList() {
    if (boxMovies.get('key_${widget.movieID}') != null) {
      buttonText = "Watched the Movie";
      showButton = false;
    }
  }

  void checkWatchlist() {
    if (boxNeedToWatch.get('key_${widget.movieID}') != null) {
      setState(() {
        buttonText = "Already on WatchList";
        showButton = false;
      });
    }
  }

  @override
  void initState() {
    getMovieData();
    checkWatchedList();
    checkWatchlist();
    super.initState();
  }

  getMovieData() async {
    TMDB tmdbLogs = TMDB(ApiKeys(API_Key, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map movieData = await tmdbLogs.v3.movies.getDetails(widget.movieID);
    Map movieCast = await tmdbLogs.v3.movies.getCredits(widget.movieID);
    Map movieSimilar = await tmdbLogs.v3.movies.getSimilar(widget.movieID);

    setState(() {
      movie = movieData.values.toList();
      castMovie = movieCast['cast'];
      similarMovies = movieSimilar['results'];
    });
    print(movie);
  }

  void _addmovie() async {
    //save movie to Watchlist
    setState(() {
      setState(() {
        boxNeedToWatch.put(
            'key_${widget.movieID}',
            needtowatch(
                movieTitle: movie.contains('original_title').toString(),
                movieID: widget.movieID,
                star: movie.contains('vote_average').toString(),
                posterurl: movie.contains('poster_path').toString()));
        //change button
        buttonText = "Added to Watclist";
        showButton = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavDrawer(),
      endDrawer: const MyProfileDrawer(),
      appBar: const MyAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                    child: Center(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width - 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500' + movie[1]),
                          fit: BoxFit.cover,
                        )),
                  ),
                )),
                Positioned(
                    bottom: 10,
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Text(
                              star.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ],
                        ))),
                Positioned(
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 20, top: 12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Text(
              movie[10],
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'release date: ${movie.contains('release_date')}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 220,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage('https://image.tmdb.org/t/p/w500' +
                            movie.contains('poster_path').toString()),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                  height: 220,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 170,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 142, 132, 151),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 1),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                movie[11],
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: showButton ? _addmovie : null,
                            style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.onBackground,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary),
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
          ),
          Container(
              margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: const SizedBox(
                height: 50,
              ))
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
                    title: movie.contains('original_title').toString(),
                    posterurl: 'https://image.tmdb.org/t/p/w500' +
                        movie.contains('poster_path').toString(),
                    rating: movie.contains('vote_average').toString()));
          },
          label: const Text('Watched'),
          icon: const Icon(Icons.visibility),
        ),
      ),
    );
  }
}
