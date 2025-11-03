import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/features/movies/data/repositories/movie_repository.dart';
import 'package:movie_browser_app/src/features/movies/presentation/empty_movie_search.dart';
import 'package:movie_browser_app/src/features/movies/presentation/movie_list_item.dart';
import 'package:movie_browser_app/src/features/movies/presentation/movie_list_tile_error.dart';
import 'package:movie_browser_app/src/features/movies/presentation/movie_list_tile_shimmer.dart';
import 'package:movie_browser_app/src/features/search/presentation/movies_search_notifier_provider.dart';
import 'package:movie_browser_app/src/features/search/presentation/search_field.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(moviesSearchQueryNotifierProvider);
    final searchMoviesAsyncValue = ref.watch(
      fetchMoviesProvider((page: 1, query: query)),
    );
    final totalResults = searchMoviesAsyncValue.value?.totalResults;

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
            if (totalResults == 0) EmptyMovieSearch(query: query),

            Expanded(
              child: GridView.builder(
                key: ValueKey(query),
                padding: const EdgeInsets.all(AppSpacing.s),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.55,
                ),
                itemCount: totalResults,
                itemBuilder: (context, index) {
                  final page = index ~/ pageSize + 1;
                  final indexInPage = index % pageSize;
                  final responseAsync = ref.watch(
                    // pass both the page and query to the fetchMoviesProvider
                    fetchMoviesProvider((page: page, query: query)),
                  );
                  return responseAsync.when(
                    data: (data) {
                      // This condition only happens if a null itemCount is given
                      if (indexInPage >= data.results.length) {
                        return null;
                      }

                      return MovieListItem(movie: data.results[indexInPage]);
                    },
                    loading: () => const MovieListTileShimmer(),
                    error: (err, stack) => MovieListTileError(
                      query: query,
                      page: page,
                      indexInPage: indexInPage,
                      error: err.toString(),
                      isLoading: responseAsync.isLoading,
                    ),
                  );
                },
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
