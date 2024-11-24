import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popcorn/screens/people/controller/people_controller.dart';
import 'package:popcorn/screens/people/model/people_model.dart';

class PeopleView extends StatefulWidget {
  const PeopleView({super.key, required this.id});

  final int id;

  @override
  State<PeopleView> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {
  final myScrollController = ScrollController();
  late Future<PeopleModel> futurePeople;
  final PeopleController _controller = PeopleController();

  @override
  void initState() {
    super.initState();
    futurePeople = _controller.getPeopleData(widget.id);
  }

  Future<void> _refreshPage() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      futurePeople = _controller.getPeopleData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<PeopleModel>(
      future: futurePeople,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          bool showImage = true;
          if (snapshot.data!.profilePath == null) {
            showImage = false;
          }
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: RefreshIndicator(
              onRefresh: _refreshPage,
              child: Scrollbar(
                  controller: myScrollController,
                  child: ListView(
                    controller: myScrollController,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 75, top: 32),
                              child: Center(
                                  child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.name,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(snapshot.data!.birthday),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 220,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: showImage
                                          ? NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${snapshot.data!.profilePath}')
                                          : const AssetImage(
                                                  'assets/images/poster404.jpg')
                                              as ImageProvider,
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        } else {
          return const Text('No Data Found');
        }
      },
    ));
  }
}
