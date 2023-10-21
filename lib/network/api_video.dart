import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiVideo{
  Uri? link;

  Future<String?> getTrailerVideoKey(int idMovie) async {
    link = Uri.parse(
      'https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=053927dbbf61ee0f685143bc3c08fe2e&language=es-MX&page=1'
    );
    final response = await http.get(link!);
    if(response.statusCode == 200){
      final List<dynamic> videos = jsonDecode(response.body)['results'];
      for(final video in videos){
        if(video['type'] == 'Trailer'){
          return video['key'];
        }
      }
    }
    return null;
  }
}