import 'package:flutter/material.dart';
import 'package:pmsn20232/database/favoritos.dart';
import 'package:pmsn20232/models/popular_model.dart';
import 'package:pmsn20232/network/api_popular.dart';
import 'package:pmsn20232/widgets/item_movie_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  ApiPopular? apiPopular;
  FavoritosDB? favoritosDB;
  List<int> idsMovies = [];

  Future<void> fetchMovieData() async {
    List<PopularModel> movies = await favoritosDB!.getAllFavoriteMovies();
    setState(() {
      idsMovies = movies.map((movie) => movie.id!).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    favoritosDB = FavoritosDB();
    fetchMovieData();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: arguments['screen'] != 'favorite' ? const Text('Popular Movies') : const Text('Favorite Movies'),
      ),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasData) {
            List<PopularModel> filteredMovies = [];
            if (arguments['screen'] == 'favorite') {
              // * Filtrar las películas favoritas
              filteredMovies = snapshot.data!.where((movie) => idsMovies.contains(movie.id)).toList();
            } else {
              // * Mostrar todas las películas
              filteredMovies = snapshot.data!;
            }
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 1,
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return Hero(
                  tag: filteredMovies[index].id!,
                  flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {// Puedes ajustar la duración
                    return SizeTransition(
                      sizeFactor: animation,
                      child: toHeroContext.widget,
                    );
                  },
                  child: itemMoviewidget(filteredMovies[index], context)
                );
              },
            );
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Algo salió mal.'));
            } else {
              return const CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}