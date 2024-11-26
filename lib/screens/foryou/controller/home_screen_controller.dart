import 'package:popcorn/screens/foryou/model/movie_preview_model.dart';

class HomeScreenController {
  Future<MoviePreviewModel> getNowPlaying() async {
    return await MoviePreviewModel.fetchNowPlaying();
  }

  Future<MoviePreviewModel> getPopular() async {
    return await MoviePreviewModel.fetchPopular();
  }

  Future<MoviePreviewModel> getTopRated() async {
    return await MoviePreviewModel.fetchTopRated();
  }
}
