import 'package:flutter/material.dart';
import 'package:pmsn20232/database/Favoritos.dart';
import 'package:pmsn20232/models/popular_model.dart';
import 'package:pmsn20232/screens/detail_movie_screen.dart';

class MovieButtons extends StatefulWidget {
  const MovieButtons({
    super.key, required this.model
  });

  final PopularModel model;

  @override
  State<MovieButtons> createState() => _MovieButtonsState();
}

class _MovieButtonsState extends State<MovieButtons> {
  FavoritosDB? favoritosDB;
  List<PopularModel> favorite = [];

  @override
  void initState() {
    super.initState();
    favoritosDB = FavoritosDB();
    getFavoriteMovie();
  }

  Future<void> getFavoriteMovie() async {
    favorite = (await favoritosDB?.getMovieById(widget.model.id!))!;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return RowSpaceEvenly(
      children: [
        // Text('L: ${favorite.length.toString()}'),
        IconButton(
          icon: Icon(
            favorite.isNotEmpty
            ? Icons.favorite
            : Icons.favorite_border,
          ),
          onPressed: () async {
            if (favorite.isEmpty) {
              await favoritosDB!.insert('tblFavorites', {
                'id': widget.model.id,
                'overview': widget.model.overview,
                'posterPath': widget.model.posterPath,
                'title': widget.model.title,
              });              
            } else {
              favoritosDB!.delete('tblFavorites', favorite[0].id!).then((value) {
              });
            }
            setState(() {
              getFavoriteMovie();
            });
          },
        ),
        IconButton(
          onPressed: () {
            
          },
          icon: const Icon(Icons.download)
        ),
        IconButton(
          onPressed: () {
            
          },
          icon: const Icon(Icons.share)
        )
      ]
    );
  }
}
