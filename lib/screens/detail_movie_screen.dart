import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn20232/models/popular_model.dart';
import 'package:pmsn20232/widgets/blurred_background_web.dart';
import 'package:pmsn20232/widgets/card_cast.dart';
import 'package:pmsn20232/widgets/movie_buttons.dart';
import 'package:pmsn20232/widgets/shared/rating_bar.dart';
import 'package:pmsn20232/widgets/video_trailer.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({
    super.key,
  });

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  PopularModel? movie;
  String? videoKey;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    movie = arguments['movie'] as PopularModel;
    videoKey = arguments['key'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Movie"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.pushNamed(context, '/popular', arguments: {'screen': 'favorite'});
            },
          ),
        ]
      ),
      body: Stack(
        children: [
          BlurredBackgroundWeb(
            tag: movie!.id!,
            backgroundUrl: 'https://image.tmdb.org/t/p/w500/${movie!.posterPath}'
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16), // Ajusta el valor para controlar el grado de redondeo
                    child: CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500/${movie!.posterPath}',
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      width: 180,
                    ),
                  ),
                ),
                Text(
                  movie!.title!, 
                  style: const TextStyle( fontSize: 24, fontWeight: FontWeight.bold ),
                  textAlign: TextAlign.center,
                ), // * Titulo
                RowSpaceEvenly(
                  children: [
                    TextBold(
                      textBold: 'Date: ',
                      text: DateFormat('yyy-MM-dd').format(movie!.releaseDate!)
                    ),
                    TextBold(
                      textBold: 'Votes: ',
                      text: movie!.voteCount!.toString()
                    ),
                  ]
                ),
                MovieButtons(model: movie!),
                Ratingbar(
                  rating: movie!.voteAverage!/2,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    movie!.overview!,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: VideoTrailer(videoKey: videoKey ?? "DkFJE8ZdeG8"),
                ),
                const Text(
                  "Cast", 
                  style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 230,
                  child: CardCast(idMovie: movie!.id!)
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}

class RowSpaceEvenly extends StatelessWidget {
  const RowSpaceEvenly({
    super.key,
    required this.children
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}

class TextBold extends StatelessWidget {
  const TextBold({
    super.key,
    required this.textBold,
    required this.text,
  });

  final String textBold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: '$textBold ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: text),
        ],
      ),
    );
  }
}