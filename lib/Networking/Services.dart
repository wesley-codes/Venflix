import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:venflix/Networking/GenreModel.dart';

class Api {
  var httpClient = http.Client();
  static const apiKey = "db8c29de96767df9c748f50d557a61df";
  static const url = "https://api.themoviedb.org/3";

  // ignore: missing_return
  Future<List<PopularMoviesModel>> fetchPopularMovies() async {
    final response = await http.get("$url/movie/popular?api_key=$apiKey");

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)["results"].cast<Map<String, dynamic>>();
      print(parsed);
      return parsed
          .map<PopularMoviesModel>((json) => PopularMoviesModel.fromJson(json))
          .toList();
    } else {
        print(response.statusCode);
      throw Exception("Failed to load popular movies");
    
    }
  }
}
