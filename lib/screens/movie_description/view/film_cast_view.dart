import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/controller/movie_desc_controller.dart';
import 'package:popcorn/screens/movie_description/model/film_cast_model.dart';

class FilmCastView extends StatefulWidget {
  const FilmCastView({super.key, required this.movieID});

  final int movieID;

  @override
  State<FilmCastView> createState() => _FilmCastViewState();
}

class _FilmCastViewState extends State<FilmCastView> {
  late Future<FilmCastModel> futureFilmCast;
  final movieDescriptionController _controller = movieDescriptionController();

  @override
  void initState() {
    super.initState();
    futureFilmCast = _controller.getFilmCast(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 0),
      child: FutureBuilder(
          future: futureFilmCast,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 8),
                      width: double.infinity,
                      child: const Text(
                        'Movie Cast',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    height: 165,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.cast.length,
                        itemBuilder: (context, index) {
                          bool showImage = true;
                          if (snapshot.data!.cast[index].profilePath == null) {
                            showImage = false;
                          }
                          return InkWell(
                            splashColor: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              width: 80,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: showImage
                                                        ? NetworkImage(
                                                            'https://image.tmdb.org/t/p/w500${snapshot.data!.cast[index].profilePath}')
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
                                            snapshot.data!.cast[index]
                                                    .character ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w800,
                                                overflow: TextOverflow.fade),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: Expanded(
                                        child: Center(
                                      child: Text(
                                        snapshot.data!.cast[index].name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    )),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            } else {
              return const Text('No Data Found');
            }
          }),
    );
  }
}
