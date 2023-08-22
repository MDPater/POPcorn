import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription(
      {super.key,
      required this.title,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.release_date});

  final String title, description, bannerurl, posterurl, vote, release_date;

  //Widget to build Movie Description Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ListView(
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage(bannerurl),
                        fit: BoxFit.cover,
                      )
                    ),
                  )
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Rating - ' + vote /* +'⭐' */,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.arrow_back_ios_new, size: 24, color: Theme.of(context).colorScheme.primary,)
                  ),
                )
              ],
            ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.only(left: 8, top: 8, right: 8),
              child: Text(title, style: TextStyle(fontSize: 24),),
            ),
            Container(
              padding: EdgeInsets.only(left:12),
              child: Text('release date: '+release_date, style: TextStyle(fontSize: 12),),
            ),
            SizedBox(height: 15,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 200,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: NetworkImage(posterurl), fit: BoxFit.cover)
                    ),
                  ),
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width / 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(description),
                    ) 
                  )
                ],
              ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton.extended(
            onPressed: (){
              
            },
            label: Text('Watched'),
            icon: Icon(Icons.visibility),
          ),
        ),
      );
  }
}
