import 'package:http/http.dart' as http;
import 'package:venflix/Models/genre_Model.dart';
import 'package:venflix/Models/moviemodel.dart';

import 'dart:convert';
import 'package:venflix/Models/trending_Model.dart';

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

      return parsed
          .map<PopularMoviesModel>((json) => PopularMoviesModel.fromJson(json))
          .toList();
    } else {
      print(response.statusCode);
      throw Exception("Failed to load popular movies");
    }
  }

  // ignore: non_constant_identifier_names
  Future<List<GenreModel>> GenreMovies() async {
    final response = await http.get("$url/movie/popular?api_key=$apiKey");

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)["Genre"].cast<Map<String, dynamic>>();

      return parsed
          .map<GenreModel>((json) => GenreModel.fromjson(json))
          .toList();
    } else {
      print(response.statusCode);
      throw Exception("Failed to load popular movies");
    }
  }

  Future<MovieModel> getMovieInfo(int movieId) async {
    final response = await http.get("$url/movie/$movieId?api_key=$apiKey");

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }
}
