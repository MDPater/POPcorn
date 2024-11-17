// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/view/movie_desc_view.dart';

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({super.key, required this.TopRated});

  final List TopRated;

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  //Widget that builds Top Rated cards on Home Screen
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top Rated', style: TextStyle(fontSize: 24)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.TopRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(2),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => movieDescriptionView(
                                    movieID: widget.TopRated[index]['id'],
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 195,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            widget.TopRated[index]
                                                ['poster_path']))),
                          ),
                          Container(
                            child: Text(
                              widget.TopRated[index]['title'] ?? 'Loading',
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
