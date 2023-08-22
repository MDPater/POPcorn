// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description.dart';

class InTheatre extends StatelessWidget {
  const InTheatre({super.key, required this.Theatre});

  final List Theatre;

  //Widget that builds Top Rated cards on Home Screen

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('In Theatre Now', style: TextStyle(fontSize: 24)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Theatre.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(2),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDescription(
                                  movieID: Theatre[index]['id'],
                                  title: Theatre[index]['title'],
                                  description: Theatre[index]['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      Theatre[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      Theatre[index]['poster_path'],
                                  vote:
                                      Theatre[index]['vote_average'].toString(),
                                  release_date: Theatre[index]
                                      ['release_date'])));
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
                                            Theatre[index]['poster_path']))),
                          ),
                          Container(
                            child: Text(
                              Theatre[index]['title'] ?? 'Loading',
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
