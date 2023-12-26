import 'package:flutter/material.dart';
import 'package:popcorn/model/boxes.dart';
import 'package:popcorn/model/need_to_watch/needtowatch.dart';
import 'package:popcorn/screens/watched/watched_bottomsheet.dart';

class MovieDescription extends StatefulWidget {
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

  @override
  State<MovieDescription> createState() => _MovieDescriptionState();
}

class _MovieDescriptionState extends State<MovieDescription> {
  bool showButton = true;

  void toggleButtonOn() {
    setState(() {
      showButton = true;
    });
  }

  void toggleButtonOff() {
    setState(() {
      showButton = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _addmovie() async {
    setState(() {
      print("Movie Added to Need To Watch List");
      //save movie to Need to Watch List
      setState(() {
        boxNeedToWatch.put(
            'key_${widget.movieID}',
            needtowatch(
                movieTitle: widget.title,
                movieID: widget.movieID,
                star: star,
                posterurl: widget.posterurl));
        print(boxNeedToWatch.values);
      });
    });
  }

  //Widget to build Movie Description Screen
  @override
  Widget build(BuildContext context) {
    star = (num.parse(widget.vote) / 2).toStringAsFixed(1);
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
                          image: NetworkImage(widget.bannerurl),
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
              widget.title,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'release date: ${widget.release_date}',
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
                height: 220,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(widget.posterurl),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                  height: 220,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 170,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 142, 132, 151),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 1),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                widget.description,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: showButton ? _addmovie : null,
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).colorScheme.primary,
                                onPrimary:
                                    Theme.of(context).colorScheme.onBackground),
                            child: const Text(
                              'Need to Watch',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 25, left: 25, right: 25),
              child: SizedBox(
                height: 50,
              ))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => WatchedBottomSheet(
                    movieID: widget.movieID,
                    title: widget.title,
                    posterurl: widget.posterurl,
                    rating: widget.vote));
          },
          label: const Text('Watched'),
          icon: const Icon(Icons.visibility),
        ),
      ),
    );
  }
}
