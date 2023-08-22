import 'package:flutter/material.dart';
import 'package:popcorn/screens/watchlist/watched.dart';

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

  //Widget to build Movie Description Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage(bannerurl),
                        fit: BoxFit.cover,
                      )
                    ),
                  )
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(8)),
                    child: Row(children: [
                      Text(vote, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                      Icon(Icons.star, color: Theme.of(context).colorScheme.primary,)
                    ],)
                  )
                ),
                Positioned(
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 12, top: 12),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      icon: Icon(Icons.arrow_back_ios_new, size: 24, color: Theme.of(context).colorScheme.primary,),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                )
              ],
            ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
              child: Text(title, style: const TextStyle(fontSize: 24),),
            ),
            Container(
              padding: const EdgeInsets.only(left:12),
              child: Text('release date: $release_date', style: const TextStyle(fontSize: 12),),
            ),
            const SizedBox(height: 15,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 200,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: NetworkImage(posterurl), fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width / 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(description),
                    ) 
                  )
                ],
              ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Watched(title: title, posterurl: posterurl, releasedate: release_date,)));
            },
            label: const Text('Watched'),
            icon: const Icon(Icons.visibility),
          ),
        ),
      );
  }
}
