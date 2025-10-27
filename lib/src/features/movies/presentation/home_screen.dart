import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/features/movies/data/repositories/movie_repository.dart';
import 'package:movie_browser_app/src/features/movies/presentation/movie_list.dart';
import 'package:movie_browser_app/src/features/search/presentation/movies_search_notifier_provider.dart';
import 'package:movie_browser_app/src/features/search/presentation/no_results.dart';
import 'package:movie_browser_app/src/features/search/presentation/search_field.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMoviesAsyncValue = ref.watch(popularMoviesProvider);
    final searchMoviesAsyncValue = ref.watch(moviesSearchResultProvider);
    final searchQuery = ref.watch(moviesSearchQueryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Popular Movies', style: AppTypography.headlineMedium),
        leading: const _MenuButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.m),
            SearchField(
              hintText: 'Search for a movie...',
              onChanged: (value) => ref
                  .read(moviesSearchQueryNotifierProvider.notifier)
                  .update(value),
            ),
            const SizedBox(height: AppSpacing.m),
            Expanded(
              child: searchQuery.isEmpty
                  ? popularMoviesAsyncValue.when(
                      data: (paginatedResponse) {
                        final movies = paginatedResponse.results;
                        return MovieList(movies: movies);
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error: ${error.toString()}',
                              style: AppTypography.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.m),
                            ElevatedButton(
                              onPressed: () =>
                                  ref.invalidate(popularMoviesProvider),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : searchMoviesAsyncValue.when(
                      data: (paginatedResponse) {
                        final movies = paginatedResponse.results;
                        if (movies.isEmpty) {
                          return const NoResults();
                        }
                        return MovieList(movies: movies);
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error: ${error.toString()}',
                              style: AppTypography.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.m),
                            ElevatedButton(
                              onPressed: () =>
                                  ref.invalidate(moviesSearchProvider),
                              child: const Text('Retry'),
                            ),
                          ],
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

class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: const Icon(Icons.menu_rounded), onPressed: () {});
  }
}
