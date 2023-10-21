import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/models/popular_model.dart';
import 'package:pmsn20232/network/api_video.dart';

Widget itemMoviewidget(PopularModel movie, context) {
  String? videoKey;
  ApiVideo().getTrailerVideoKey(movie.id!).then((key){
    videoKey = key;
    GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
  });

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/detailMovie', arguments: {'movie': movie, 'key': videoKey});
    },
    child: CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}

// child: FadeInImage(
//   fit: BoxFit.fill,
//   fadeInDuration: const Duration(milliseconds: 500),
//   placeholder: const AssetImage('assets/icons/icon_movie.png'),
//   image: NetworkImage(
//       'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
//   )
// ),