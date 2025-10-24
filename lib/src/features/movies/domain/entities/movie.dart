// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final String? releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.voteAverage,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }

  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        other.voteAverage == voteAverage &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        voteAverage.hashCode ^
        releaseDate.hashCode;
  }

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, overview: $overview, posterPath: $posterPath, voteAverage: $voteAverage, releaseDate: $releaseDate)';
  }
}
