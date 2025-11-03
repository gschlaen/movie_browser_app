import 'package:flutter/material.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:shimmer/shimmer.dart';

class MovieListTileShimmer extends StatelessWidget {
  const MovieListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const titleHeight = 18.0;
    const ratingHeight = 14.0;

    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Image placeholder ---
            Expanded(child: Container(color: Colors.white)),

            // --- 2. Content text placeholder ---
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    width: double.infinity,
                    height: titleHeight,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Rating placeholder
                  Row(
                    children: [
                      // Icon placeholder
                      Container(width: 16.0, height: 16.0, color: Colors.white),
                      const SizedBox(width: AppSpacing.s),
                      // Rating text placeholder
                      Container(
                        width: 40.0,
                        height: ratingHeight,
                        color: Colors.white,
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
