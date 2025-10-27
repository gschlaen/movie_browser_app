import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/features/movies/domain/entities/movie.dart';
import 'package:movie_browser_app/src/routing/app_router.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed(
          AppRoute.movieDetail.name,
          pathParameters: {'id': movie.id.toString()},
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: movie.posterPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16.0),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.ratingText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
