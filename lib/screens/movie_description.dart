import 'package:flutter/material.dart';
import 'package:popcorn/screens/watched/watched_bottomsheet.dart';

var star;

class MovieDescription extends StatelessWidget {
  const MovieDescription(
      {super.key,
      required this.movieID,
      required this.title,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.release_date});

  final String title, description, bannerurl, posterurl, vote, release_date;
  final int movieID;

  //Widget to build Movie Description Screen
  @override
  Widget build(BuildContext context) {
    star = (num.parse(vote) / 2).toStringAsFixed(1);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                    child: Center(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width - 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                          image: NetworkImage(bannerurl),
                          fit: BoxFit.cover,
                        )),
                  ),
                )),
                Positioned(
                    bottom: 10,
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Text(
                              star.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ],
                        ))),
                Positioned(
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 20, top: 12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Text(
              title,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'release date: $release_date',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 200,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(posterurl), fit: BoxFit.cover)),
              ),
              SizedBox(
                  height: 210,
                  width: MediaQuery.of(context).size.width / 2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(description),
                  ))
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => WatchedBottomSheet(
                    movieID: movieID,
                    title: title,
                    posterurl: posterurl,
                    rating: vote));
          },
          label: const Text('Watched'),
          icon: const Icon(Icons.visibility),
        ),
      ),
    );
  }
}
