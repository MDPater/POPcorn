import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/view/movie_desc_view.dart';

//import App navigation modules
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavDrawer.dart';
import 'package:popcorn/widgets/ProfileDrawer.dart';

//import Movie Widgets
import 'package:popcorn/screens/foryou/view/now_playing_view.dart';
import 'package:popcorn/screens/foryou/view/top_rated_view.dart';
import 'package:popcorn/screens/foryou/view/popular_view.dart';

//import TMDB
import 'package:tmdb_api/tmdb_api.dart';
import '../../../constants/api_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SearchController controller = SearchController();

  List searchMovies = [];

  Future<void> _refreshPage() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  _getMovies(String searchValue) async {
    TMDB tmdbLogs = TMDB(ApiKeys(API_Key, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map searchResult =
        await tmdbLogs.v3.search.queryMovies(searchValue, region: 'US');

    setState(() {
      searchMovies = searchResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Main Scaffold that holds Layout and links to widgets
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyNavDrawer(),
      endDrawer: const MyProfileDrawer(),
      appBar: const MyAppBar(),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              SearchAnchor(
                  viewHintText: 'Search...',
                  viewLeading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        controller.closeView(controller.text);
                        searchMovies.clear();
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                  viewTrailing: [
                    IconButton(
                        onPressed: () {
                          controller.clear();
                          searchMovies.clear();
                        },
                        icon: const Icon(Icons.clear))
                  ],
                  searchController: controller,
                  isFullScreen: false,
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      leading: const Icon(Icons.search),
                      hintText: 'Search Movies',
                      onTap: () {
                        controller.text = '';
                        controller.openView();
                        controller.addListener(() {
                          setState(() {
                            _getMovies(controller.text);
                            if (controller.text == '') {
                              searchMovies.clear();
                            }
                          });
                        });
                      },
                    );
                  },
                  suggestionsBuilder: (context, controller) {
                    return List<ListTile>.generate(searchMovies.length,
                        (index) {
                      final String item = searchMovies[index]['original_title'];
                      final String year = searchMovies[index]['release_date'];
                      final int movieID = searchMovies[index]['id'];
                      final String posterPath =
                          searchMovies[index]['poster_path'].toString();
                      return ListTile(
                        leading: Image.network(
                          'https://image.tmdb.org/t/p/w500$posterPath',
                          fit: BoxFit.fitHeight,
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/poster404.jpg');
                          },
                        ),
                        title: Text(item),
                        subtitle: Text(year),
                        splashColor: Theme.of(context).colorScheme.primary,
                        onTap: () {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            //show movie description page
                            controller.closeView(item);
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => movieDescriptionView(
                                          movieID: movieID,
                                        )));
                          });
                        },
                      );
                    });
                  }),
              const SizedBox(
                height: 30,
              ),
              const PopularView(),
              const NowPlayingView(),
              const TopRatedView(),
            ]),
          ),
        ),
      ),
    );
  }
}
