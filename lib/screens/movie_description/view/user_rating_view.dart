import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
    futureUserReview = _controller.getMovieEntry(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
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
                  Row(
                    children: [Text(snapshot.data!.comment)],
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
