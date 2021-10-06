import 'package:flutter/material.dart';
import 'package:peliculas/helpers/http_helper.dart';
import 'package:peliculas/models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peliculas/widgets/horizontal_movies.dart';

class DetailPage extends StatelessWidget {
  static const ROUTE = "/detail";

  final Movie movie;
  const DetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    //final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    String pathFull, pathPosted;

    if (movie.backdrop_path == null) {
      pathFull =
          "https://static8.depositphotos.com/1583396/1059/i/950/depositphotos_10595403-stock-photo-spotlight-room.jpg";
    } else {
      pathFull = HttpHelper.baseUrlImage + movie.backdrop_path;
    }

    if (movie.poster_path == null) {
      pathPosted =
          "https://static8.depositphotos.com/1583396/1059/i/950/depositphotos_10595403-stock-photo-spotlight-room.jpg";
    } else {
      pathPosted = HttpHelper.baseUrlImage + movie.poster_path;
    }

    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: "title_${movie.id}",
            child: Text(
              movie.title,
              style: Theme.of(context).textTheme.headline1,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(pathFull),
            Card(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Hero(
                            tag: "poster_${movie.id}",
                            child: Image.network(
                              pathPosted,
                              width: 80,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              RatingBar.builder(
                                itemCount: 5,
                                initialRating: movie.vote_average / 2,
                                allowHalfRating: true,
                                itemSize: 20,
                                itemBuilder: (
                                  context,
                                  _,
                                ) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                                onRatingUpdate: (_) {},
                                ignoreGestures: true,
                              ),
                              Text(
                                "Votos: " + (movie.vote_average / 2).toString(),
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          movie.release_date,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      movie.overview,
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Top 15",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    FutureBuilder(
                      future: HttpHelper.getTop(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return HorizontalMovies(movieResponse: snapshot.data);
                        }
                        return SizedBox();
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
