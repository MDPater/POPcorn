// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/view/movie_desc_view.dart';

class TrendingMovies extends StatefulWidget {
  const TrendingMovies({super.key, required this.Trending});

  final List Trending;

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  //Widget that builds trending Cards on Home Screen
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trending', style: TextStyle(fontSize: 24)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.Trending.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => movieDescriptionView(
                                    movieID: widget.Trending[index]['id'])));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 250,
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            widget.Trending[index]
                                                ['backdrop_path']),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              widget.Trending[index]['title'] ?? 'Loading',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
