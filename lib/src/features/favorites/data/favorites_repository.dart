import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_repository.g.dart';

class FavoritesRepository {
  FavoritesRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _favoritesKey = 'favoriteMovieIds';

  List<int> loadFavoriteMovieIds() {
    final ids = _prefs.getStringList(_favoritesKey);
    return ids?.map(int.parse).toList() ?? [];
  }

  Future<void> saveFavoriteMovieIds(List<int> movieIds) async {
    await _prefs.setStringList(
      _favoritesKey,
      movieIds.map((id) => id.toString()).toList(),
    );
  }

  bool isFavorite(int movieId) {
    final favoriteIds = loadFavoriteMovieIds();
    return favoriteIds.contains(movieId);
  }

  Future<void> addFavorite(int movieId) async {
    final favoriteIds = loadFavoriteMovieIds();
    if (!favoriteIds.contains(movieId)) {
      favoriteIds.add(movieId);
      await saveFavoriteMovieIds(favoriteIds);
    }
  }

  Future<void> removeFavorite(int movieId) async {
    final favoriteIds = loadFavoriteMovieIds();
    if (favoriteIds.contains(movieId)) {
      favoriteIds.remove(movieId);
      await saveFavoriteMovieIds(favoriteIds);
    }
  }

  Future<void> toggleFavorite(int movieId) async {
    if (isFavorite(movieId)) {
      await removeFavorite(movieId);
    } else {
      await addFavorite(movieId);
    }
  }
}

@riverpod
FavoritesRepository favoritesRepository(Ref ref) {
  throw UnimplementedError();
}

@riverpod
class FavoriteMovieIdsNotifier extends _$FavoriteMovieIdsNotifier {
  @override
  List<int> build() {
    final prefs = ref.watch(favoritesRepositoryProvider);
    return prefs.loadFavoriteMovieIds();
  }

  Future<void> toggleFavorite(int movieId) async {
    final favoritesRepository = ref.read(favoritesRepositoryProvider);
    await favoritesRepository.toggleFavorite(movieId);
    state = favoritesRepository.loadFavoriteMovieIds();
  }
}
