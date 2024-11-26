import 'package:flutter/material.dart';
import 'package:popcorn/screens/people/controller/people_controller.dart';
import 'package:popcorn/screens/people/model/people_model.dart';
import 'package:popcorn/screens/people/view/people_credit_view.dart';

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

  Future<void> _refreshPage() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      futurePeople = _controller.getPeopleData(widget.id);
    });
  }

  @override
  void initState() {
    super.initState();
    futurePeople = _controller.getPeopleData(widget.id);
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
          return Text('Error: ${snapshot.hasError}');
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
                      //Top Bar
                      SizedBox(
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            const Spacer(),
                            Positioned(
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.only(top: 15),
                                child: Center(
                                    child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.name,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                      snapshot.data!.birthday ?? 'N/A',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                )),
                              ),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                      //Picture and Biography
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
                                height: 220,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 142, 132, 151),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, bottom: 5, top: 1),
                                    child: Scrollbar(
                                      controller: myScrollController,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Text(
                                            snapshot.data!.biography,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      //id
                      /*Center(
                        child: Text(snapshot.data!.id.toString()),
                      ),*/
                      PeopleCreditView(id: widget.id),
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
