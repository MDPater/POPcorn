import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/film_cast_model.dart';
import 'package:popcorn/screens/people/view/people_view.dart';

class FilmCrewView extends StatefulWidget {
  const FilmCrewView({super.key, required this.movieID});
  final int movieID;

  @override
  State<FilmCrewView> createState() => _FilmCrewViewState();
}

class _FilmCrewViewState extends State<FilmCrewView> {
  late Future<FilmCastModel> futureFilmCrew;
  final movieDescriptionController _controller = movieDescriptionController();

  @override
  void initState() {
    super.initState();
    futureFilmCrew = _controller.getFilmCast(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: FutureBuilder(
          future: futureFilmCrew,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              if (snapshot.data!.crew.isEmpty) {
                return Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 8),
                        width: double.infinity,
                        child: const Text(
                          'Movie Crew',
                          style: TextStyle(fontSize: 20),
                        )),
                    const Center(
                      child: Text(
                        "No Crew for Movie",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                );
              } else {
                return Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 8),
                        width: double.infinity,
                        child: const Text(
                          'Movie Crew',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      height: 145,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.crew.length,
                          itemBuilder: (context, index) {
                            bool showImage = true;
                            if (snapshot.data!.crew[index].profilePath ==
                                null) {
                              showImage = false;
                            }
                            return InkWell(
                              splashColor:
                                  Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PeopleView(
                                              id: snapshot
                                                  .data!.cast[index].id)));
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                width: 70,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey),
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: showImage
                                                        ? NetworkImage(
                                                            'https://image.tmdb.org/t/p/w500${snapshot.data!.crew[index].profilePath}')
                                                        : const AssetImage(
                                                                'assets/images/poster404.jpg')
                                                            as ImageProvider,
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                        Container(
                                            padding:
                                                const EdgeInsets.only(top: 1),
                                            height: 25,
                                            child: Expanded(
                                              child: Text(
                                                  snapshot.data!.crew[index]
                                                          .job ??
                                                      '...',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 7,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      overflow:
                                                          TextOverflow.fade)),
                                            ))
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Expanded(
                                          child: Center(
                                              child: Text(
                                        snapshot.data!.crew[index].name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w900),
                                      ))),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                );
              }
            } else {
              return const Text('No Data Found');
            }
          }),
    );
  }
}
