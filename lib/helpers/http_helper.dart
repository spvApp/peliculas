import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/movie_response.dart';

class HttpHelper {
  static final String key = '?api_key=8361d405286c686c4b2245a20aafd60e';
  static final String url = 'https://api.themoviedb.org/3/';
  static final String baseUrlImage = 'https://image.tmdb.org/t/p/w500';

  static Future<MovieResponse?> getPopular(int page) async {
    final res = await http.get(Uri.parse(HttpHelper.url +
        "movie/popular" +
        HttpHelper.key +
        "&page=" +
        page.toString()));
    if (res.statusCode == HttpStatus.ok) {
      final jsonMap = json.decode(res.body);
      final MovieResponse movieResponse = MovieResponse.fromJson(jsonMap);
      return movieResponse;
    } else {
      return null;
    }
  }

  static Future<MovieResponse?> getTop() async {
    final res = await http
        .get(Uri.parse(HttpHelper.url + "movie/top_rated" + HttpHelper.key));
    if (res.statusCode == HttpStatus.ok) {
      final jsonMap = json.decode(res.body);
      final MovieResponse movieResponse = MovieResponse.fromJson(jsonMap);
      return movieResponse;
    } else {
      return null;
    }
  }

  static Future<MovieResponse?> getSearch(int page, String text) async {
    final res = await http.get(Uri.parse(HttpHelper.url +
        "search/movie" +
        HttpHelper.key +
        "&page=" +
        page.toString() +
        "&query=" +
        text));
    if (res.statusCode == HttpStatus.ok) {
      final jsonMap = json.decode(res.body);
      final MovieResponse movieResponse = MovieResponse.fromJson(jsonMap);
      return movieResponse;
    } else {
      return null;
    }
  }
}
