import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/src/features/movies/data/repositories/movie_repository.dart';

class MoviesSearchQueryNotifier extends Notifier<String> {
  /// Used to debounce the input queries
  Timer? _debounceTimer;

  @override
  String build() {
    // Close the StreamController and cancel the subscriptions on dispose
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return '';
  }

  void update(String newValue) {
    // Cancel the timer if it is active
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // only update the state once the query has been debounced
      state = newValue;
    });
  }
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
