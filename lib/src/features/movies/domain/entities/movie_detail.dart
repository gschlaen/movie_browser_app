// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final String? releaseDate;
  final List<String> genres;
  final int? runtime;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.voteAverage,
    this.releaseDate,
    required this.genres,
    this.runtime,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] as String?,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => e['name'] as String)
          .toList(),
      runtime: json['runtime'] as int?,
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
      'genres': genres.map((e) => {'name': e}).toList(),
      'runtime': runtime,
    };
  }

  @override
  bool operator ==(covariant MovieDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        other.voteAverage == voteAverage &&
        other.releaseDate == releaseDate &&
        listEquals(other.genres, genres) &&
        other.runtime == runtime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        voteAverage.hashCode ^
        releaseDate.hashCode ^
        genres.hashCode ^
        runtime.hashCode;
  }

  @override
  String toString() {
    return 'MovieDetail(id: $id, title: $title, overview: $overview, posterPath: $posterPath, voteAverage: $voteAverage, releaseDate: $releaseDate, genres: $genres, runtime: $runtime)';
  }
}
