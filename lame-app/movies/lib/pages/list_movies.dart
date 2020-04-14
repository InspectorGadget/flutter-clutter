import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies/pages/movie_details.dart';
import 'package:movies/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ListMovies extends StatefulWidget {
  @override
  _ListMoviesState createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  static String apiKey = "YourAPIKey";
  String url = "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey";

  var movies = [];

  fetchMovies() async {
    var response = await http.get(url);
    var data = json.decode(response.body);

    setState(() {
      movies = data['results'];
    });
  }

  Future<void> _refreshController() {
    setState(() {
      movies = null;
    });

    return fetchMovies();
  }

  @override
  void initState() {
    fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sicko Movies by Raeveen'),
        actions: <Widget>[
          Switch(
            value: _themeProvider.getTheme() == ThemeData.dark() ? true : false,
            onChanged: (value) {
              _themeProvider.setTheme(
                value ? ThemeData.dark() : ThemeData.light(),
              );
            },
          )
        ],
      ),
      body: movies == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshController,
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int i) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 8.0,
                    margin: EdgeInsets.all(16.0),
                    child: InkWell(
                      radius: 8.0,
                      child: getCardView(context, movies[i]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MovieDetail(movies[i]);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget getCardView(BuildContext context, movie) {
    final String imageUrl = "https://image.tmdb.org/t/p/w500/";

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: movie['poster_path'],
          child: Container(
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl + movie['poster_path']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 5.0,
          ),
          child: Text(
            movie['title'],
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arvo',
            ),
          ),
        )
      ],
    );
  }
}
