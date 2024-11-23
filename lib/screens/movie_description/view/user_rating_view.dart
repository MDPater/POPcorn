import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/user_rating_model.dart';

class UserRatingView extends StatefulWidget {
  const UserRatingView(
      {super.key, required this.movieID, required this.myScrollController});

  final int movieID;
  final ScrollController myScrollController;

  @override
  State<UserRatingView> createState() => _UserRatingViewState();
}

class _UserRatingViewState extends State<UserRatingView> {
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
              return const SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  //Widget Title
                  Container(
                    padding: const EdgeInsets.only(top: 0),
                    width: double.infinity,
                    child: const Text(
                      'Your Review ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  //Star Rating
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
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
                                child: Center(
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
