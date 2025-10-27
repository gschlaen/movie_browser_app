
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/src/common/api/api_client.dart';
import 'package:movie_browser_app/src/features/movies/domain/entities/genre.dart';

class GenreRepository {
  GenreRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Genre>> getMovieGenres() async {
    final response = await _apiClient.get('genre/movie/list');
    final genres = (response['genres'] as List)
        .map((genre) => Genre.fromJson(genre as Map<String, dynamic>))
        .toList();
    return genres;
  }
}

final genreRepositoryProvider = Provider<GenreRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GenreRepository(apiClient);
});

final movieGenresProvider = FutureProvider<List<Genre>>((ref) {
  final genreRepository = ref.watch(genreRepositoryProvider);
  return genreRepository.getMovieGenres();
});
