import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

var star;

class WatchedBottomSheet extends StatelessWidget {
  WatchedBottomSheet({
    super.key,
    required this.movieID,
    required this.title,
    required this.posterurl,
    required this.rating,
  });

  final String title, posterurl, rating;
  final int movieID;

  var ratingvalue;

  @override
  Widget build(BuildContext context) {
    star = (num.parse(rating) / 2).toStringAsFixed(1);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: 800,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
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
                                image: NetworkImage(posterurl),
                                fit: BoxFit.fill)),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              child: Row(children: [
                                Text(
                                  star.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar(
                      itemSize: 50,
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          half: const Icon(
                            Icons.star_half,
                            color: Colors.orange,
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Colors.orange,
                          )),
                      onRatingUpdate: (value) {
                        ratingvalue = value;
                      }),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
<<<<<<< HEAD
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black38),
=======
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black38),
>>>>>>> eb1b5a14f3db3d17ae5a4bf31e7f29820c9aa39d
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(8),
                child: TextField(
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(
<<<<<<< HEAD
                    hintText: "Comments or Notes on this movie", 
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    contentPadding: const EdgeInsets.all(8),
                    border: InputBorder.none
                  ),
=======
                      hintText: "Comments or Notes on this movie",
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      contentPadding: const EdgeInsets.all(8),
                      border: InputBorder.none),
>>>>>>> eb1b5a14f3db3d17ae5a4bf31e7f29820c9aa39d
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    //save Movie to Watchlist
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Add to List'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
