import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/movie_user_model.dart';

class userRatingView extends StatefulWidget {
  const userRatingView({super.key, required this.movieID});

  final int movieID;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Review ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                  ),
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
                                  left: 8, right: 8, top: 8, bottom: 1),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  snapshot.data!.comment,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
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
