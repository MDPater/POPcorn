import 'package:flutter/material.dart';

var star;

class Watched extends StatelessWidget {
  const Watched({
    super.key,
    required this.title,
    required this.posterurl,
    required this.rating,
  });

  final String title, posterurl, rating;

  @override
  Widget build(BuildContext context) {
    star = double.parse(rating) / 2;
    return Container(
      height: 400,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      child: ListView(
        children: [
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 200,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(posterurl), fit: BoxFit.fill)),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          child: Row(children: [
                            Text(
                              star.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ]),
                        )
                      ])
                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.star_border_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.star_border_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.star_border_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.star_border_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.star_border_outlined)),
          ]),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.check),
              label: const Text('Add to List'),
            ),
          )
        ],
      ),
    );
  }
}
