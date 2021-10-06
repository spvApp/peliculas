import 'package:peliculas/helpers/http_helper.dart';

class Movie {
  late bool adult;
  late String backdrop_path;
  late String belongs_to_collection;
  late int budget;
  late String genres;
  late int id;
  late String name;
  late String homepage;
  late String imdb_id;
  late String original_language;
  late String original_title;
  late String overview;
  late double popularity;
  late String poster_path;
  late String production_companies;
  late String logo_path;
  late String origin_country;
  late String production_countries;
  late String iso_3166_1;
  late String release_date;
  late String revenue;
  late String runtime;
  late String spoken_languages;
  late String english_name;
  late String iso_639_1;
  late String status;
  late String tagline;
  late String title;
  late bool video;
  late double vote_average;
  late int vote_count;

  Movie(
      {required this.adult,
      required this.backdrop_path,
      required this.belongs_to_collection,
      required this.budget,
      required this.genres,
      required this.id,
      required this.name,
      required this.homepage,
      required this.imdb_id,
      required this.original_language,
      required this.original_title,
      required this.overview,
      required this.popularity,
      required this.poster_path,
      required this.production_companies,
      required this.logo_path,
      required this.origin_country,
      required this.production_countries,
      required this.iso_3166_1,
      required this.release_date,
      required this.revenue,
      required this.runtime,
      required this.spoken_languages,
      required this.english_name,
      required this.iso_639_1,
      required this.status,
      required this.tagline,
      required this.title,
      required this.video,
      required this.vote_average,
      required this.vote_count});

  getImagePoster() {
    if (this.poster_path == null) {
      return "https://static8.depositphotos.com/1583396/1059/i/950/depositphotos_10595403-stock-photo-spotlight-room.jpg";
    }
    return HttpHelper.baseUrlImage + this.poster_path;
  }

  Movie.empty()
      : this.id = 0,
        this.backdrop_path = "",
        this.original_language = "",
        this.original_title = "",
        this.overview = "",
        this.popularity = 0,
        this.poster_path = "",
        this.release_date = "",
        this.title = "",
        this.vote_average = 0,
        this.vote_count = 0;

  Movie.fromJson(Map<String, dynamic> movieMap)
      : this.id = movieMap['id'],
        this.backdrop_path = movieMap['backdrop_path'],
        this.original_language = movieMap['original_language'],
        this.original_title = movieMap['original_title'],
        this.overview = movieMap['overview'],
        this.popularity = movieMap['popularity'],
        this.poster_path = movieMap['poster_path'],
        this.release_date = movieMap['release_date'] == null
            ? "Sin fecha"
            : movieMap['release_date'],
        this.title = movieMap['title'],
        this.vote_average = double.parse(movieMap['vote_average'].toString()),
        this.vote_count = movieMap['vote_count'];
}
