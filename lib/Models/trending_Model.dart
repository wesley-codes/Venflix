class PopularMoviesModel {
  // ignore: non_constant_identifier_names
  final String original_title;
  final String overview;
  // ignore: non_constant_identifier_names
  final num vote_average, popularity, vote_count;
  // ignore: non_constant_identifier_names
  final String release_date;
  // ignore: non_constant_identifier_names
  final String poster_path;
// ignore: non_constant_identifier_names
  final int id;

  PopularMoviesModel(
      // ignore: non_constant_identifier_names
      {
    this.original_title,
    this.overview,
    // ignore: non_constant_identifier_names
    this.release_date,
    // ignore: non_constant_identifier_names
    this.vote_average,
    // ignore: non_constant_identifier_names
    this.poster_path,
    this.popularity,
    // ignore: non_constant_identifier_names
    this.vote_count,
    this.id
  });

  factory PopularMoviesModel.fromJson(Map<String, dynamic> json) {
    return PopularMoviesModel(
      id: json["id"],
        original_title: json["original_title"],
        overview: json["overview"],
        release_date: json["release_date"],
        vote_average: json["vote_average"],
        poster_path: json["poster_path"],
        popularity: json["popularity"],
        vote_count: json["vote_count"]);
  }
}
