import 'package:popcorn/screens/movie_description/model/movie_desc_model.dart';

class movieDescriptionController {
  Future<movieDescriptionModel> getMovieData(int movieID) async {
    return await movieDescriptionModel.fetchMovieData(movieID);
  }
}
