import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/features/movies/data/repositories/movie_repository.dart';
import 'package:movie_browser_app/src/features/movies/presentation/movie_list_item.dart';
import 'package:movie_browser_app/src/features/search/presentation/search_field.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMoviesAsyncValue = ref.watch(popularMoviesProvider);

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
              onChanged: (v) => {},
            ),
            const SizedBox(height: AppSpacing.m),
            Expanded(
              child: popularMoviesAsyncValue.when(
                data: (paginatedResponse) {
                  final movies = paginatedResponse.results;
                  return GridView.builder(
                    padding: const EdgeInsets.all(AppSpacing.s),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.55,
                        ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieListItem(movie: movie);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${error.toString()}',
                        style: AppTypography.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.m),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(popularMoviesProvider),
                        child: Text('Retry'),
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
