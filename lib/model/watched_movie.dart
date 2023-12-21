class watched_movie {
  final String movieTitle;
  final String posterurl;
  final double starRating;
  final int movieID;

  watched_movie(
      {required this.movieTitle,
      required this.posterurl,
      required this.starRating,
      required this.movieID});

  Map<String, dynamic> toMap() {
    return {
      'movieTitle': this.movieTitle,
      'posterurl': this.posterurl,
      'starRating': this.starRating,
      'movieID': this.movieID
    };
  }

  factory watched_movie.fromMap(Map map) {
    return watched_movie(
        movieTitle: map['movieTitle'],
        posterurl: map['posterurl'],
        starRating: map['starRating'],
        movieID: map['movieID']);
  }

  @override
  String toString() {
    return 'movieTitle: $movieTitle posterurl: $posterurl starRating: $starRating movieID: $movieID';
  }
}
