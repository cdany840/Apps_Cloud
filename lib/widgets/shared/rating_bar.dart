import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Ratingbar extends StatelessWidget {
  const Ratingbar({
    super.key,
    required this.rating,
    this.ignoreGestures,
    this.color
  });

  final double rating;
  final bool? ignoreGestures;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating, // ? Debería recibir un valor.
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: ignoreGestures ?? true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: color ?? Colors.grey,
      ),
      onRatingUpdate: (rating) {
        
      },
    );
  }
}