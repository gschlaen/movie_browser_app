import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/features/favorites/data/favorites_repository.dart';
import 'package:movie_browser_app/src/features/movies/data/genre_repository.dart';
import 'package:movie_browser_app/src/features/movies/domain/entities/movie.dart';
import 'package:movie_browser_app/src/features/movies/presentation/genre_chip.dart';
import 'package:movie_browser_app/src/utils/date_formatter.dart';
import 'package:movie_browser_app/src/utils/vote_count_formatter.dart';

class MovieDetailScreen extends ConsumerWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMovieIdsProvider).contains(movie.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Movie Details', style: AppTypography.headlineMedium),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              ref
                  .read(favoriteMovieIdsProvider.notifier)
                  .toggleFavorite(movie.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MoviePoster(posterPath: movie.posterPath),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHorizontal,
                vertical: AppSpacing.pageVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MovieHeader(
                    title: movie.title,
                    releaseDate: movie.releaseDate,
                  ),
                  const SizedBox(height: AppSpacing.l),
                  _GenreTags(genreIds: movie.genreIds),
                  const SizedBox(height: AppSpacing.l),
                  _RatingDisplay(
                    voteAverage: movie.voteAverage,
                    voteCount: movie.voteCount,
                  ),
                  const SizedBox(height: AppSpacing.l),
                  _MovieOverview(movie: movie),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({required this.posterPath});

  final String? posterPath;

  @override
  Widget build(BuildContext context) {
    if (posterPath == null) {
      return const Center(child: Icon(Icons.movie, size: 100));
    }
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w500$posterPath',
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

class _MovieHeader extends ConsumerWidget {
  const _MovieHeader({required this.title, required this.releaseDate});

  final String title;
  final String? releaseDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatted = releaseDate != null
        ? ref.watch(dateFormatterProvider).format(releaseDate!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.headlineMedium),
        const SizedBox(height: AppSpacing.s),
        if (dateFormatted != null)
          Text(
            dateFormatted,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

class _GenreTags extends ConsumerWidget {
  const _GenreTags({required this.genreIds});

  final List<int> genreIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresValue = ref.watch(movieGenresProvider);

    return genresValue.when(
      data: (genres) {
        final movieGenres = genres
            .where((genre) => genreIds.contains(genre.id))
            .toList();

        return Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: movieGenres
              .map((genre) => GenreChip(label: genre.name))
              .toList(),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => const Text('Could not load genres'),
    );
  }
}

class _RatingDisplay extends ConsumerWidget {
  const _RatingDisplay({required this.voteAverage, required this.voteCount});

  final double voteAverage;
  final double voteCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voteCountFormatted = ref.watch(voteCountProvider).format(voteCount);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.star_outline_rounded, // Outlined star icon
          color: AppColors.star,
          size: 20,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '${voteAverage.toStringAsFixed(1)}/10',
          style: AppTypography.titleMedium,
        ),
        const SizedBox(width: AppSpacing.s),
        Text(
          '($voteCountFormatted reviews)',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _MovieOverview extends StatelessWidget {
  const _MovieOverview({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview', style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.s),
        Text(
          movie.overview,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
