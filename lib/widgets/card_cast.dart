import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/models/cast_model.dart';
import 'package:pmsn20232/network/api_cast.dart';

class CardCast extends StatefulWidget {
  const CardCast({super.key, required this.idMovie});

  final int idMovie;

  @override
  State<CardCast> createState() => _CardCastState();
}

class _CardCastState extends State<CardCast> {
  ApiCast? apiCast;

  @override
  void initState() {
    apiCast = ApiCast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiCast?.getAllCast(widget.idMovie),
      builder: (
        BuildContext context, 
        AsyncSnapshot<List<CastModel>?> snapshot){
          if(snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = snapshot.data![index];
                if (movie.knownForDepartment == "Acting") {
                  if (movie.profilePath != null) {
                    return Container(
                      margin: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          ClipOval(
                            // borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.profilePath}',
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              width: 80,
                            ),
                          ),
                          const Text('Name', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(movie.name!),
                          const Text('Character', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(movie.character!),
                          ],
                        ),
                    );                    
                  }
                }
                return null;
              }
            );
          } else {
            return const Text('Something was wrong!');
          }
        },
    );
  }
}