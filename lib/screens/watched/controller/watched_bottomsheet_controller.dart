import 'package:popcorn/screens/watched/model/watched_bottomsheet_model.dart';

class WatchedBottomsheetController {
  Future<WatchedBottomsheetModel> getMovieData(int id) async {
    return await WatchedBottomsheetModel.fetchMovieData(id);
  }
}
