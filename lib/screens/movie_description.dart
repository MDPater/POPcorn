import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription(
      {super.key,
      required this.title,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.release_date});

  final String title, description, bannerurl, posterurl, vote, release_date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  )),
                  Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          '⭐ Rating - ' + vote,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.background),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
