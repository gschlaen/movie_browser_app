import 'package:flutter/material.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/features/movies/domain/entities/movie.dart';
import 'package:movie_browser_app/src/features/movies/presentation/movie_list_item.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.s),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
  }
}
