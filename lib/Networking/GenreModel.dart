class PopularMoviesModel {
  // ignore: non_constant_identifier_names
  final String original_title;
  final String overview;
  // ignore: non_constant_identifier_names
  final int vote_average;
  // ignore: non_constant_identifier_names
  final String release_date;
  // ignore: non_constant_identifier_names
  final String poster_path;
// ignore: non_constant_identifier_names
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
  });

  factory PopularMoviesModel.fromJson(Map<String, dynamic> json) {
    return PopularMoviesModel(
      original_title: json["original_title"],
      overview: json["overview"],
      release_date: json["release_date"],
    
      poster_path: json["poster_path"]
    );
  }
}
