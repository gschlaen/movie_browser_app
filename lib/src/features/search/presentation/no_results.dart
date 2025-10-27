import 'package:flutter/material.dart';
import 'package:movie_browser_app/design_system/foundations.dart';

class NoResults extends StatelessWidget {
  const NoResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.movie_creation_outlined,
            size: 100,
            color: AppColors.onSurface,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            'No results found',
            style: AppTypography.bodyLarge.copyWith(color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }
}
