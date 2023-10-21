import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pmsn20232/models/popular_model.dart';

class ApiPopular {
  Uri link = Uri.parse(
    'https://api.themoviedb.org/3/movie/popular?api_key=053927dbbf61ee0f685143bc3c08fe2e&language=es-MX&page=1'
  );

  Future<List<PopularModel>?> getAllPopular() async {
    var response = await http.get(link);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['results'] as List;
      return jsonResult
          .map((popular) => PopularModel.fromJson(popular))
          .toList();
    }
    return null;
  }
}
//flutter pub add http