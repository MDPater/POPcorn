import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/model/movie_user_model.dart';

class userRatingView extends StatefulWidget {
  const userRatingView({super.key, required this.futureUserReview});

  final Future<movieUserDataModel> futureUserReview;

  @override
  State<userRatingView> createState() => _userRatingViewState();
}

class _userRatingViewState extends State<userRatingView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Review'),
    );
  }
}
