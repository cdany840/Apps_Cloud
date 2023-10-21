import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pmsn20232/models/cast_model.dart';

class ApiCast{
  Uri? link;

  Future<List<CastModel>?> getAllCast(int idMovie) async {
    link = Uri.parse( // * 575264
      'https://api.themoviedb.org/3/movie/575264/credits?api_key=053927dbbf61ee0f685143bc3c08fe2e&language=es-MX&page=1'
    );
    var response = await http.get(link!);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['cast'] as List;
      return jsonResult
          .map((popular) => CastModel.fromJson(popular))
          .toList();
    }
    return null;
  }
}

  // Future<List<Map<String, dynamic>>?> getCast(int idMovie) async {
  //   link = Uri.parse(
  //     'https://api.themoviedb.org/3/movie/$idMovie/credits?api_key=053927dbbf61ee0f685143bc3c08fe2e&language=es-MX&page=1'
  //   );
  //   final response = await http.get(link!);
  //   if(response.statusCode == 200){
  //     final Map<String, dynamic> data = jsonDecode(response.body);
  //     final List<Map<String, dynamic>> cast = List<Map<String, dynamic>>.from(data['cast']);
  //     return cast;
  //   }
  //   return null;
  // }