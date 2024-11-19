import 'package:popcorn/screens/movie_description/model/movie_desc_model.dart';
import 'package:popcorn/screens/movie_description/model/movie_user_model.dart';

class movieDescriptionController {
  Future<movieDescriptionModel> getMovieData(int movieID) async {
    return await movieDescriptionModel.fetchMovieData(movieID);
  }

  Future<movieUserDataModel> getMovieEntry(int movieID) async {
    return await movieUserDataModel.fetchMovieEntry(movieID);
  }
}
