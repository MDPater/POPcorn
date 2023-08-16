// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({super.key, required this.TopRated});

  final List TopRated;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top Rated Movies', style: TextStyle(fontSize: 24)),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 260,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: TopRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(2),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5),
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
                                            TopRated[index]['poster_path']))),
                          ),
                          Container(
                            child: Text(
                              TopRated[index]['title'] ?? 'Loading',
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
