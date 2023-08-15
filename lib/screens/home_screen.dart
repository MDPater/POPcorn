import 'package:flutter/material.dart';
import 'package:popcorn/data/top_rated_movies.dart';
import 'package:http/http.dart' as http;
import 'package:popcorn/widget/movie_preview.dart';

String appbarTitle = "POPcorn";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search Movies',
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Text('Top Rated Movies', style: TextStyle(fontSize: 24)),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureBuilder<List<Movie>>(
                    future: fetchMovies(http.Client()),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return const Center(
                          child: Text('Error 404'));
                      } else if(snapshot.hasData){
                        return movieItem(movies: snapshot.data!);
                      }else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    }
                  )
                ],
              ),
            )
          ]),
        ));
  }
}

AppBar _buildAppBar(context) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.menu,
          color: Colors.black,
          size: 24,
        ),
        Text(appbarTitle),
        const SizedBox(
          height: 40,
          width: 40,
          child: Icon(Icons.person, size: 30),
        )
      ],
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
  );
}
