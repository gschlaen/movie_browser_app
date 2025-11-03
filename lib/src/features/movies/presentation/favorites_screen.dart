import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/features/favorites/data/favorites_repository.dart';
import 'package:movie_browser_app/src/features/movies/data/repositories/movie_repository.dart';
import 'package:movie_browser_app/src/features/movies/presentation/movie_list.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovieIds = ref.watch(favoriteMovieIdsProvider);

    if (favoriteMovieIds.isEmpty) {
      return Center(
        child: Text(
          'No favorite movies yet!',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      );
    }

    final favoriteMoviesAsync = ref.watch(
      moviesByIdsProvider(favoriteMovieIds),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Favorites', style: AppTypography.headlineMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
        child: Column(
          children: [
            Expanded(
              child: favoriteMoviesAsync.when(
                data: (movies) => MovieList(movies: movies),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text(
                    'Error loading favorites: $error',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
