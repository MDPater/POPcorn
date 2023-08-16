// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({super.key, required this.TopRated});

  final List TopRated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top Rated Movies', style: TextStyle(fontSize: 24)),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: TopRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            TopRated[index]['poster_path']))),
                          ),
                          Container(
                            child: Text(TopRated[index]['title']),
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
