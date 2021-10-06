import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/helpers/http_helper.dart';
import 'package:peliculas/helpers/transitions.dart';
import 'package:peliculas/models/movie_response.dart';
import 'package:peliculas/movies/detail_page.dart';

class ListPage extends StatefulWidget {
  static const String ROUTE = "/";

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  MovieResponse? movieResponse = MovieResponse.empty();

  ScrollController _scrollController = ScrollController();

  bool _loadData = false;
  Icon _barVisibleIcon = Icon(Icons.search);
  Widget _barSearch = Text("Listado de peliculas");

  @override
  void initState() {
    _scrollController.addListener(() {
      //print(_scrollController.position.pixels); // posicion del usuario
      //print(_scrollController.position.maxScrollExtent); // posicion maxima

      if (_scrollController.position.pixels >=
              (_scrollController.position.maxScrollExtent - 50) &&
          !_loadData) {
        _dataList();
      }
    });
    _dataList();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose(); //se usa para finalizar el escuchador.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _barSearch,
        actions: [
          IconButton(
              onPressed: () {
                if (this._barVisibleIcon.icon == Icons.search) {
                  this._barVisibleIcon = Icon(Icons.cancel);
                  this._barSearch = TextField(
                    style: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (text) {
                      movieResponse = MovieResponse.empty();
                      _dataList(text: text);
                    },
                  );
                } else {
                  movieResponse = MovieResponse.empty();
                  this._barVisibleIcon = Icon(Icons.search);
                  this._barSearch = Text("Listado de peliculas");
                  _dataList();
                }
                setState(() {});
              },
              icon: _barVisibleIcon)
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: this.movieResponse == null
                    ? 0
                    : this.movieResponse!.movies.length,
                itemBuilder: (_, int position) {
                  var m = this.movieResponse!.movies[position];
                  var image;

                  if (m.poster_path == null) {
                    image = NetworkImage(
                        "https://static8.depositphotos.com/1583396/1059/i/950/depositphotos_10595403-stock-photo-spotlight-room.jpg");
                  } else {
                    //image = Image.network(HttpHelper.baseUrlImage + m.poster_path);
                    image =
                        NetworkImage(HttpHelper.baseUrlImage + m.poster_path);
                  }

                  return Card(
                    elevation: 2.0,
                    child: ListTile(
                      leading: Hero(
                        tag: "poster_${m.id}",
                        child: CircleAvatar(
                          backgroundImage: image,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Hero(
                        tag: "title_${m.id}",
                        child: Text(m.title,
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      subtitle: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            m.release_date,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          )),
                      onTap: () {
                        //Navigator.pushNamed(context, DetailPage.ROUTE,
                        //arguments: m);

                        //Navegacion por defecto.

                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return DetailPage(movie: m,);
                          }),
                        );*/

                        //Navegacion con transiciones.

                        Navigator.push(
                            context,
                            CustomSizeTransition(DetailPage(
                              movie: m,
                            )));
                      },
                    ),
                  );
                }),
          ),
          Container(
            height: _loadData ? 20 : 0,
            width: 20,
            child: CircularProgressIndicator(),
          )
        ],
      )),
    );
  }

  _dataList({String text = ""}) async {
    setState(() {
      _loadData = true;
    });
    final movieResponseAux = await (_barVisibleIcon.icon == Icons.search
        ? HttpHelper.getPopular(movieResponse!.page)
        : HttpHelper.getSearch(movieResponse!.page, text));

    if (movieResponseAux != null && movieResponseAux.movies.length > 0)
      setState(() {
        this.movieResponse!.movies.addAll(movieResponseAux.movies);
        movieResponse!.page = movieResponse!.page + 1;
        _loadData = false;
      });
  }
}
