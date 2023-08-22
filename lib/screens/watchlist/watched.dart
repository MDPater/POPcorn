import 'package:flutter/material.dart';

class Watched extends StatelessWidget {
  const Watched({
    super.key,
    required this.title,
    required this.posterurl,
    required this.releasedate,
  });

  final String title, posterurl, releasedate;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Column(children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      releasedate,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
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
          FloatingActionButton.extended(
            onPressed: () {},
            icon: const Icon(Icons.check),
            label: const Text('Add to List'),
          )
        ],
      ),
    );
  }
}
