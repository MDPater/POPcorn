import 'package:flutter/material.dart';
import 'package:popcorn/screens/movie_description/view/movie_desc_view.dart';
import 'package:popcorn/screens/people/controller/people_controller.dart';
import 'package:popcorn/screens/people/model/people_credit_model.dart';

class PeopleCreditView extends StatefulWidget {
  const PeopleCreditView({super.key, required this.id});

  final int id;

  @override
  State<PeopleCreditView> createState() => _PeopleCreditViewState();
}

class _PeopleCreditViewState extends State<PeopleCreditView> {
  late Future<PeopleCreditModel> futurePeopleCredit;
  final PeopleController _controller = PeopleController();

  @override
  void initState() {
    super.initState();
    futurePeopleCredit = _controller.getPeopleCredit(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          //In Movie Cast title
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8),
              child:
                  const Text('In Movie Cast', style: TextStyle(fontSize: 20))),
          //List of Movies
          FutureBuilder(
              future: futurePeopleCredit,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data!.cast.isEmpty) {
                    return Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('No Credits'));
                  }
                  return Container(
                    height: 240,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.cast.length,
                        itemBuilder: (context, index) {
                          bool showImage = true;
                          if (snapshot.data!.cast[index].posterPath == null) {
                            showImage = false;
                          }
                          return InkWell(
                            splashColor: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            movieDescriptionView(
                                                movieID: snapshot
                                                    .data!.cast[index].id)));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: 240,
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                    height: 195,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: showImage
                                                ? NetworkImage(
                                                    'https://image.tmdb.org/t/p/w500${snapshot.data!.cast[index].posterPath}')
                                                : const AssetImage(
                                                        'assets/images/poster404.jpg')
                                                    as ImageProvider)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.cast[index].title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return const Text('No Data Found');
                }
              }),
          //Movie Crew Credits title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8),
            child: const Text(
              'Movie Crew Credits',
              style: TextStyle(fontSize: 20),
            ),
          ),
          //List of Movies
          FutureBuilder(
              future: futurePeopleCredit,
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
                    return Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('No Credits'));
                  }
                  return Container(
                    height: 220,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.crew.length,
                        itemBuilder: (context, index) {
                          bool showImage = true;
                          if (snapshot.data!.crew[index].posterPath == null) {
                            showImage = false;
                          }
                          return InkWell(
                            splashColor: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            movieDescriptionView(
                                                movieID: snapshot
                                                    .data!.crew[index].id)));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              height: 200,
                              width: 110,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 130,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: showImage
                                                      ? NetworkImage(
                                                          'https://image.tmdb.org/t/p/w500${snapshot.data!.crew[index].posterPath}')
                                                      : const AssetImage(
                                                              'assets/images/poster404.jpg')
                                                          as ImageProvider,
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          height: 40,
                                          child: Expanded(
                                            child: Center(
                                              child: Text(
                                                  snapshot
                                                      .data!.crew[index].title,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      overflow:
                                                          TextOverflow.fade)),
                                            ),
                                          ))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Expanded(
                                        child: Center(
                                            child: Text(
                                      snapshot.data!.crew[index].job ?? '...',
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
                  );
                } else {
                  return const Text('No Data Found');
                }
              })
        ],
      ),
    );
  }
}
