import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/src/common/api/api_client.dart';
import 'package:movie_browser_app/src/common/models/paginated_response.dart';
import 'package:movie_browser_app/src/features/movies/domain/entities/movie.dart';

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
      try {
        final movie = await fetchMovieById(id);
        movies.add(movie);
      } catch (e) {
        // Log error or handle it as per application's error handling policy
      }
    }
    return movies;
  }

  Future<PaginatedResponse<Movie>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    final response = await _apiClient.get(
      'search/movie',
      queryParameters: {'query': query, 'page': page.toString()},
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

final popularMoviesProvider = FutureProvider<PaginatedResponse<Movie>>((
  ref,
) async {
  return ref.watch(movieRepositoryProvider).fetchPopularMovies();
});

final moviesByIdsProvider = FutureProvider.family<List<Movie>, List<int>>(
  (ref, movieIds) async {
    final movieRepository = ref.watch(movieRepositoryProvider);
    return movieRepository.fetchMoviesByIds(movieIds);
  },
);

final moviesSearchProvider =
    FutureProvider.family<PaginatedResponse<Movie>, String>((
      ref,
      String query,
    ) async {
      final movieSearchRepository = ref.watch(movieRepositoryProvider);
      return movieSearchRepository.searchMovies(query: query, page: 1);
    });
