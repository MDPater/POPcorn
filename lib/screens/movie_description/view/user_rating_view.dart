import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/movie_user_model.dart';

class userRatingView extends StatefulWidget {
  const userRatingView(
      {super.key, required this.movieID, required this.myScrollController});

  final int movieID;
  final ScrollController myScrollController;

  @override
  State<userRatingView> createState() => _userRatingViewState();
}

class _userRatingViewState extends State<userRatingView> {
  late Future<movieUserDataModel> futureUserReview;
  final movieDescriptionController _controller = movieDescriptionController();

  @override
  void initState() {
    super.initState();
    futureUserReview = _controller.getMovieEntry(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: futureUserReview,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  //Widget Title
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    width: double.infinity,
                    child: Text(
                      'Your Review ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  //Star Rating
                  Container(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Column(
                      children: [
                        RatingBar(
                          initialRating: snapshot.data!.starRating,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemSize: 50,
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
                          onRatingUpdate: (value) {},
                        )
                      ],
                    ),
                  ),
                  //Comment and Watched On Date
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 8,
                        child: (Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 142, 132, 151),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 1),
                              child: Scrollbar(
                                controller: widget.myScrollController,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    snapshot.data!.comment,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ))),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 8,
                        child: Column(
                          children: [
                            const Text(
                              'Watched on: ',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(
                                snapshot.data!.watchedAt,
                              ),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            } else {
              return const Text('No Data Found');
            }
          },
        ));
  }
}
