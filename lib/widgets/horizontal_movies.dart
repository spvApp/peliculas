import 'package:flutter/material.dart';
import 'package:peliculas/models/movie_response.dart';
import 'package:peliculas/movies/detail_page.dart';

class HorizontalMovies extends StatelessWidget {
  final MovieResponse movieResponse;

  const HorizontalMovies({required this.movieResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              this.movieResponse == null ? 0 : this.movieResponse.movies.length,
          itemBuilder: (_, int position) {
            var m = this.movieResponse.movies[position];

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DetailPage.ROUTE,
                            arguments: m);
                      },
                      child: Image.network(m.getImagePoster()))),
            );
          }),
    );
  }
}
