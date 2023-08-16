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
                itemCount: TopRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                  );
                }),
          )
        ],
      ),
    );
  }
}
