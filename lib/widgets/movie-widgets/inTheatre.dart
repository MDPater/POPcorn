// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description.dart';

class InTheatre extends StatefulWidget {
  const InTheatre({super.key, required this.Theatre});

  final List Theatre;

  @override
  State<InTheatre> createState() => _InTheatreState();
}

class _InTheatreState extends State<InTheatre> {
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
                itemCount: widget.Theatre.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(2),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDescription(
                                  movieID: widget.Theatre[index]['id'],
                                  title: widget.Theatre[index]['title'],
                                  description: widget.Theatre[index]
                                      ['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      widget.Theatre[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      widget.Theatre[index]['poster_path'],
                                  vote: widget.Theatre[index]['vote_average']
                                      .toString(),
                                  release_date: widget.Theatre[index]
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
                                            widget.Theatre[index]
                                                ['poster_path']))),
                          ),
                          Container(
                            child: Text(
                              widget.Theatre[index]['title'] ?? 'Loading',
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
