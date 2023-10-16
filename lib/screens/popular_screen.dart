import 'package:flutter/material.dart';
import 'package:pmsn20232/network/api_popular.dart';
import 'package:pmsn20232/network/popular_model.dart';
import 'package:pmsn20232/widgets/item_movie_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO:
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(), 
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return itemMovieWidget(snapshot.data![index]);
              },
            );          
          } else {
            if (!snapshot.hasError) {
              return const Center(
                child: Text('There is a mistake'), //! Error
              );              
            } else {
              return const CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}