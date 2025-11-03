import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/src/common/api/api_client.dart';
import 'package:movie_browser_app/src/common/models/paginated_response.dart';
import 'package:movie_browser_app/src/features/movies/domain/entities/movie.dart';

/// Metadata used when fetching movies with the paginated search API.
typedef MoviesQueryData = ({String query, int page});

class MovieRepository {
  final ApiClient _apiClient;

  MovieRepository(this._apiClient);

  Future<PaginatedResponse<Movie>> fetchPopularMovies({int page = 1}) async {
    final response = await _apiClient.get(
      'movie/popular',
      queryParameters: {'page': page.toString()},
    );
    return PaginatedResponse.fromJson(
      response,
      (json) => Movie.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<Movie> fetchMovieById(int movieId) async {
    final response = await _apiClient.get('movie/$movieId');
    return Movie.fromJson(response);
  }

  Future<List<Movie>> fetchMoviesByIds(List<int> movieIds) async {
    final movies = <Movie>[];
    for (final id in movieIds) {
      final movie = await fetchMovieById(id);
      movies.add(movie);
    }
    return movies;
  }

  Future<PaginatedResponse<Movie>> searchMovies({
    required MoviesQueryData queryData,
  }) async {
    final response = await _apiClient.get(
      'search/movie',
      queryParameters: {
        'query': queryData.query,
        'page': queryData.page.toString(),
      },
    );
    return PaginatedResponse.fromJson(
      response,
      (json) => Movie.fromJson(json as Map<String, dynamic>),
    );
  }
}

final movieRepositoryProvider = Provider((ref) {
  return MovieRepository(ref.watch(apiClientProvider));
});

final fetchMoviesProvider = FutureProvider.family
    .autoDispose<PaginatedResponse<Movie>, MoviesQueryData>((
      ref,
      MoviesQueryData queryData,
    ) async {
      final moviesRepo = ref.watch(movieRepositoryProvider);
      if (queryData.query.isEmpty) {
        // Non-search endpoint
        return moviesRepo.fetchPopularMovies(page: queryData.page);
      } else {
        // Search endpoint
        return moviesRepo.searchMovies(queryData: queryData);
      }
    });

final moviesByIdsProvider = FutureProvider.family<List<Movie>, List<int>>((
  ref,
  movieIds,
) async {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.fetchMoviesByIds(movieIds);
});
