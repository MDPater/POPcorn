import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/model/watchlist/watchedmovie.dart';

//import App navigation modules
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavBar.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({super.key});

  @override
  State<WatchedScreen> createState() => _Watched_ScreenState();
}

class _Watched_ScreenState extends State<WatchedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavBar(),
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: GridView.builder(
            itemCount: boxMovies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 2 / 4),
            itemBuilder: (context, index) {
              watchedmovie movie = boxMovies.getAt(index);
              return Container(
                padding: EdgeInsets.all(2),
                width: 140,
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 195,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movie.posterurl}')),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: RatingBar(
                          itemPadding: EdgeInsets.all(2),
                          itemSize: 12,
                          itemCount: 5,
                          allowHalfRating: true,
                          initialRating: movie.starRating,
                          ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: Colors.orange,
                              ),
                              empty: const Icon(
                                Icons.star_outline,
                                color: Colors.orange,
                              )),
                          onRatingUpdate: (value) {
                            value;
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        movie.movieTitle,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
