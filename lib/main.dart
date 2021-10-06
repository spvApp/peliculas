import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/movies/detail_page.dart';
import 'package:peliculas/movies/list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      initialRoute: ListPage.ROUTE,
      theme: ThemeData(
          //brightness: Brightness.dark,
          primaryColor: Colors.purple,
          fontFamily: "Georgia",
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 20,
            ),
            headline6: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            bodyText1: TextStyle(fontSize: 15),
          )),
      routes: {
        ListPage.ROUTE: (_) => ListPage(),
        DetailPage.ROUTE: (_) => DetailPage(
              movie: Movie.empty(),
            ),
      },
    );
  }
}
