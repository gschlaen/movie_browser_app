// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class PaginatedResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  PaginatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return PaginatedResponse(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'page': page,
      'results': results.map((e) => toJsonT(e)).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  @override
  bool operator ==(covariant PaginatedResponse<T> other) {
    if (identical(this, other)) return true;

    return other.page == page &&
        listEquals(other.results, results) &&
        other.totalPages == totalPages &&
        other.totalResults == totalResults;
  }

  @override
  int get hashCode {
    return page.hashCode ^
        results.hashCode ^
        totalPages.hashCode ^
        totalResults.hashCode;
  }

  @override
  String toString() {
    return 'PaginatedResponse(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }
}
