import 'movie.dart';

class MovieResponse {
  late int page;
  late List<Movie> movies;

  MovieResponse(this.page, this.movies);

  MovieResponse.empty() {
    this.movies = [];
    this.page = 1;
  }

  MovieResponse.fromJson(Map<String, dynamic> movieResponseMap) {
    this.page = movieResponseMap["page"];
    this.movies = List<Movie>.from(
        movieResponseMap["results"].map((m) => Movie.fromJson(m)));
  }
}
