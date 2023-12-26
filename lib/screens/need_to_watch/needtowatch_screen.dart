import 'package:flutter/material.dart';
import 'package:popcorn/widgets/AppBar.dart';
import 'package:popcorn/widgets/NavBar.dart';

class NeedToWatch extends StatefulWidget {
  const NeedToWatch({super.key});

  @override
  State<NeedToWatch> createState() => _NeedToWatchState();
}

class _NeedToWatchState extends State<NeedToWatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavBar(),
      appBar: const MyAppBar(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(children: [
        Container(
          child: Center(
            child: Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  'Need to Watch',
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          height: MediaQuery.of(context).size.height - 140,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [],
          ),
        )
      ]),
    );
  }
}
