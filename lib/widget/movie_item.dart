import 'package:flutter/material.dart';

class movieItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String information;

  final GlobalKey backgroundImageKey = GlobalKey();

  movieItem({super.key, this.imageUrl, this.information, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 200,
        width: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary),
        child: const Center(
          child: Text('Test'),
        ));
  }
}
