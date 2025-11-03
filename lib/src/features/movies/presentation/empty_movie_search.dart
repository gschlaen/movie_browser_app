import 'package:flutter/material.dart';
import 'package:movie_browser_app/design_system/foundations.dart';

class EmptyMovieSearch extends StatelessWidget {
  final String query;

  const EmptyMovieSearch({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).textTheme.bodySmall?.color;

    final String title = "No results found";
    final String subtitle = "We couldn't find any movies matching '$query'.";

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 80.0, color: secondaryColor),
            const SizedBox(height: AppSpacing.m),
            Text(
              title,
              style: AppTypography.titleMedium.copyWith(color: secondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              subtitle,
              style: AppTypography.bodyLarge.copyWith(color: secondaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
