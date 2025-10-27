import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/src/features/movies/data/repositories/movie_repository.dart';

class MoviesSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String newValue) => state = newValue;
}

/// Holds the raw search query as the user types
final moviesSearchQueryNotifierProvider =
    NotifierProvider<MoviesSearchQueryNotifier, String>(
      MoviesSearchQueryNotifier.new,
    );

final moviesSearchResultProvider = FutureProvider((ref) async {
  final searchQuery = ref.watch(moviesSearchQueryNotifierProvider);
  return ref.watch(moviesSearchProvider(searchQuery).future);
});
