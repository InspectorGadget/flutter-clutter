import 'dart:ui';

import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final movie;
  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = "https://image.tmdb.org/t/p/w500/";

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            imageUrl + movie['poster_path'],
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Hero(
                    tag: movie['poster_path'],
                    child: Container(
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl + movie['poster_path']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            movie['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arvo',
                            ),
                          ),
                        ),
                        Text(
                          '${movie['vote_average']}/10',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Arvo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    movie['overview'],
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'Arvo',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
