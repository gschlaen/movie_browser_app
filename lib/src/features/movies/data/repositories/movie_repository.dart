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
}

final movieRepositoryProvider = Provider((ref) {
  return MovieRepository(ref.watch(apiClientProvider));
});

final popularMoviesProvider = FutureProvider<PaginatedResponse<Movie>>((
  ref,
) async {
  return ref.watch(movieRepositoryProvider).fetchPopularMovies();
});
