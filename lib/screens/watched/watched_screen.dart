import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/model/watched/watchedmovie.dart';
import 'package:popcorn/screens/movie_description/detail_movie_description.dart';

//import App navigation modules
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavDrawer.dart';
import 'package:popcorn/widgets/ProfileDrawer.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({super.key});

  @override
  State<WatchedScreen> createState() => _Watched_ScreenState();
}

class _Watched_ScreenState extends State<WatchedScreen> {
  bool isShown = true;

  void _deleteMovie(BuildContext context, watchedmovie movie, int index) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Delete Movie from list'),
            content: const Text(
                'Do you want to delete the Movie from your Watchlist?'),
            actions: [
              //yes button
              TextButton(
                  onPressed: () {
                    print('${movie.movieID}" "${movie.movieTitle} " deleted"');
                    //delete Movie in Hive
                    setState(() {
                      boxMovies.deleteAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              //no button
              TextButton(
                  onPressed: () {
                    //close Dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavDrawer(),
      endDrawer: const MyProfileDrawer(),
      appBar: const MyAppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.grey),
            child: const Text(
              "Your Watched Movies",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                  size: 25,
                ),
                onPressed: () {
                  //Search Movie from list
                },
              ),
            ),
        SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                icon: const Icon(
                  Icons.view_list,
                  color: Colors.deepPurple,
                  size: 25,
                ),
                onPressed: () {
                  //Filter list by different criteria
                },
              ),
            ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          height: MediaQuery.of(context).size.height - 140,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              GridView.builder(
                  clipBehavior: Clip.hardEdge,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: boxMovies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 10 / 20),
                  itemBuilder: (context, index) {
                    watchedmovie movie = boxMovies.getAt(index);
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailMovieDescription(
                                      movieID: movie.movieID)));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        width: 140,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 125,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500${movie.posterurl}'),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Positioned(
                                    top: -8,
                                    left: -8,
                                    height: 65,
                                    width: 65,
                                    child: IconButton(
                                      splashColor: Colors.purple,

                                      //popup that asks if movie should be deleted from list
                                      onPressed: isShown == true
                                          ? () => _deleteMovie(
                                              context, movie, index)
                                          : null,

                                      icon: Icon(
                                        Icons.remove_circle,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      alignment: Alignment.topLeft,
                                    )),
                              ],
                            ),
                            RatingBar(
                                ignoreGestures: true,
                                itemPadding:
                                    const EdgeInsets.only(top: 2, bottom: 2),
                                itemSize: 15,
                                itemCount: 5,
                                allowHalfRating: true,
                                initialRating: movie.starRating,
                                ratingWidget: RatingWidget(
                                    full: const Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    half: const Icon(
                                      Icons.star_half,
                                      color: Colors.black,
                                    ),
                                    empty: const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )),
                                onRatingUpdate: (value) {}),
                            Expanded(
                              child: Center(
                                child: Text(
                                  movie.movieTitle,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 8, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ]),
    );
  }
}
