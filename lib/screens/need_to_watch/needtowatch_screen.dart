import 'package:flutter/material.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/model/need_to_watch/needtowatch.dart';
import 'package:popcorn/screens/movie_description/detail_movie_description.dart';
import 'package:popcorn/screens/watched/watched_bottomsheet.dart';
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavDrawer.dart';
import 'package:popcorn/widgets/ProfileDrawer.dart';

class NeedToWatch extends StatefulWidget {
  const NeedToWatch({super.key});

  @override
  State<NeedToWatch> createState() => _NeedToWatchState();
}

class _NeedToWatchState extends State<NeedToWatch> {
  bool isShown = true;

  void _deleteList(BuildContext context) {
    //delete Entire List
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Delete List'),
            content: const Text('Do you want to delete your List?'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      boxNeedToWatch.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavDrawer(),
      endDrawer: const MyProfileDrawer(),
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.deepPurple,
                  size: 25,
                ),
                onPressed: () {
                  //delete the List
                  _deleteList(context);
                  //with delete Dialog Box
                },
              ),
            ),
            const Spacer(),
            Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  'Watchlist',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
            const Spacer(),
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.watch,
                    color: Colors.deepPurple,
                    size: 25,
                  )),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          height: MediaQuery.of(context).size.height - 155,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: boxNeedToWatch.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, childAspectRatio: 12 / 20),
                    itemBuilder: (context, index) {
                      needtowatch movie = boxNeedToWatch.getAt(index);
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashColor: Theme.of(context).colorScheme.primary,
                        onTap: () {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailMovieDescription(
                                            movieID: movie.movieID)));
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          width: 140,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 125,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${movie.posterurl}'),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  Positioned(
                                      top: -8,
                                      left: -8,
                                      child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    WatchedBottomSheet(
                                                        movieID: movie.movieID,
                                                        title: movie.movieTitle,
                                                        posterurl:
                                                            movie.posterurl,
                                                        rating: movie.star));
                                          },
                                          icon: const Icon(Icons.add_box),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  Positioned(
                                      left: -8,
                                      bottom: -5,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            boxNeedToWatch.deleteAt(index);
                                          });
                                        },
                                        icon: const Icon(Icons.remove_circle),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      )),
                                  Positioned(
                                      bottom: 7,
                                      right: 5,
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            children: [
                                              Text(
                                                (num.parse(movie.star) / 2)
                                                    .toStringAsFixed(1),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontSize: 15),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              )
                                            ],
                                          ))),
                                ],
                              ),
                              Expanded(
                                  child: Text(
                                movie.movieTitle,
                                style: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w700),
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                              ))
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        )
      ]),
    );
  }
}
