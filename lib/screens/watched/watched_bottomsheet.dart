import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/model/watched/watchedmovie.dart';

var star;

class WatchedBottomSheet extends StatefulWidget {
  const WatchedBottomSheet(
      {super.key,
      required this.movieID,
      required this.title,
      required this.posterurl,
      required this.rating,
      required this.releaseDate});

  final String title, posterurl;
  final int movieID;
  final double rating;
  final DateTime releaseDate;

  @override
  State<WatchedBottomSheet> createState() => _WatchedBottomSheetState();
}

class _WatchedBottomSheetState extends State<WatchedBottomSheet> {
  final TextEditingController commentController = TextEditingController();

  double ratingvalue = 0.5;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool edit = boxMovies.containsKey('key_${widget.movieID}');
    star = (widget.rating / 2).toStringAsFixed(1);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: 800,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: ListView(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${widget.posterurl}'),
                                fit: BoxFit.fill)),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              child: Row(children: [
                                Text(
                                  star.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              ]),
                            )
                          ])
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar(
                      minRating: 0.5,
                      itemSize: 50,
                      initialRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
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
                        ratingvalue = value;
                      }),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black38),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(8),
                child: TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: commentController,
                  decoration: InputDecoration(
                      hintText: "Comments or Notes on this movie",
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      contentPadding: const EdgeInsets.all(8),
                      border: InputBorder.none),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if (edit) {
                      setState(() {
                        watchedmovie movie;
                        movie = boxMovies.get('key_${widget.movieID}');
                        boxMovies.put(
                            'key_${widget.movieID}',
                            watchedmovie(
                                movieTitle: widget.title,
                                posterurl: widget.posterurl,
                                starRating: ratingvalue,
                                movieID: widget.movieID,
                                comment: commentController.text.isNotEmpty
                                    ? commentController.text
                                    : movie.comment,
                                movieWatchedAt: movie.movieWatchedAt,
                                releaseDate: widget.releaseDate));
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.pop(context, 'refresh');
                        });
                      });
                    } else {
                      setState(() {
                        boxMovies.put(
                            'key_${widget.movieID}',
                            watchedmovie(
                                movieTitle: widget.title,
                                posterurl: widget.posterurl,
                                starRating: ratingvalue,
                                movieID: widget.movieID,
                                comment: commentController.text,
                                movieWatchedAt: DateTime.now(),
                                releaseDate: widget.releaseDate));
                        print("Movie ${widget.title} ${widget.movieID} Saved");
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (boxNeedToWatch.get('key_${widget.movieID}') !=
                              null) {
                            setState(() {
                              boxNeedToWatch.delete('key_${widget.movieID}');
                            });
                            print(
                                'delete ${widget.title} ${widget.movieID} from WatchList');
                          }
                          // Do something
                          Navigator.pop(context, 'refresh');
                        });
                      });
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: edit ? const Text('Edit') : const Text('Add to List'),
                  splashColor: Colors.green,
                  focusColor: Colors.green,
                  autofocus: true,
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
